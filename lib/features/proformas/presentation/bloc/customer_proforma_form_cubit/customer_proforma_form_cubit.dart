import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/proformas/domin/dtos/proforma_good_description_dto.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/use_cases/get_customer_proforma_by_id_use_case.dart';
import 'package:autro_app/features/proformas/presentation/bloc/proforma_pdf/proforma_pdf_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/use_cases/create_customer_proforma_use_case.dart';
import '../../../domin/use_cases/update_customer_proforma_use_case.dart';

part 'customer_proforma_form_state.dart';

@injectable
class CustomerProformaFormCubit extends Cubit<CustomerProformaFormState> {
  final CreateCustomerProformaUseCase createProformaUsecase;
  final UpdateCustomerProformaUseCase updateProformaUsecase;
  final GetCustomerProformaByIdUseCase getCustomerProformaByIdUseCase;
  CustomerProformaFormCubit(this.createProformaUsecase, this.updateProformaUsecase, this.getCustomerProformaByIdUseCase)
      : super(CustomerProformaFormInitial());

  // Goods Descriptions
  final descriptionController = TextEditingController();
  final containersCountController = TextEditingController();
  final weightController = TextEditingController();
  final unitPriceController = TextEditingController();
  final packingController = TextEditingController();
  final totalPriceController = TextEditingController();

  // Proforma
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final proformaNumberController = TextEditingController();
  final proformaDateController = TextEditingController();
  final customerIdController = TextEditingController();
  final customerNameController = TextEditingController();
  final taxIdController = TextEditingController();
  final portsController = TextEditingController();
  final delivaryTermsController = TextEditingController();
  final paymentTermsController = TextEditingController();
  final bankIdController = TextEditingController();
  final bankLabelController = TextEditingController();
  final notesController = TextEditingController();

  final bankAccountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final customerAddressController = TextEditingController();
  final swiftCodeController = TextEditingController();

  Future init({required int? proformaId}) async {
    if (proformaId != null) {
      final either = await getCustomerProformaByIdUseCase.call(proformaId);

      either.fold(
        (failure) {
          emit(CustomerProformaFormError(failure: failure, id: proformaId));
        },
        (proforma) {
          final goodsDescriptions = proforma.goodsDescriptions.map((e) => ProformaGoodDescriptionDto.fromEntity(e)).toList();
          emit(CustomerProformaFormLoaded(updatedMode: true, goodDescriptionsList: goodsDescriptions, proforma: proforma));
        },
      );
    } else {
      emit(const CustomerProformaFormLoaded());
    }
    await _initializeControllers();
  }

  _initializeControllers() {
    if (state is CustomerProformaFormLoaded) {
      final state = this.state as CustomerProformaFormLoaded;
      formKey.currentState?.reset();
      proformaNumberController.text = state.proforma?.proformaNumber ?? '';
      proformaDateController.text = state.proforma?.date.formattedDateYYYYMMDD ?? DateTime.now().formattedDateYYYYMMDD;
      customerIdController.text = state.proforma?.customer.id.toString() ?? '';
      customerNameController.text = state.proforma?.customer.name ?? '';
      taxIdController.text = state.proforma?.taxId ?? '';
      portsController.text = state.proforma?.ports ?? '';
      delivaryTermsController.text = state.proforma?.deliveryTerms ?? '';
      paymentTermsController.text = state.proforma?.paymentTerms ?? '';
      bankIdController.text = state.proforma?.bankAccount.id.toString() ?? '';
      bankLabelController.text = state.proforma?.bankAccount.formattedLabel ?? '';
      notesController.text = state.proforma?.notes ?? '';
      bankAccountNumberController.text = state.proforma?.bankAccount.accountNumber ?? '';
      bankNameController.text = state.proforma?.bankAccount.bankName ?? '';
      customerAddressController.text = state.proforma?.customer.formattedAddress ?? '';
      swiftCodeController.text = state.proforma?.bankAccount.swiftCode ?? '';

      _setupControllersListeners();
      _onProformaFormChanged();
    }
  }

  _setupControllersListeners() {
    // Proforma
    for (var controller in [
      proformaNumberController,
      proformaDateController,
      customerIdController,
      taxIdController,
      portsController,
      delivaryTermsController,
      paymentTermsController,
      bankIdController,
      notesController,
    ]) {
      controller.addListener(() => _onProformaFormChanged());
    }
    // Goods Descriptions
    for (var controller in [
      descriptionController,
      containersCountController,
      weightController,
      unitPriceController,
      packingController,
      totalPriceController,
    ]) {
      controller.addListener(() => _onGoodDescriptionInputChanged());
    }
  }

  _onGoodDescriptionInputChanged() {
    final addGoodDescriptionIsActive = [
      descriptionController,
      containersCountController,
      weightController,
      unitPriceController,
      packingController,
      totalPriceController,
    ].every((controller) => controller.text.isNotEmpty);

    final state = this.state as CustomerProformaFormLoaded;
    emit(state.copyWith(addGoodDescriptionEnabled: addGoodDescriptionIsActive));

    // Calculate total price
    final weight = double.tryParse(weightController.text) ?? 0;
    final unitPrice = double.tryParse(unitPriceController.text) ?? 0;
    final totalPrice = weight * unitPrice;
    totalPriceController.text = totalPrice.toStringAsFixed(2);
  }

  _onProformaFormChanged() {
    final state = this.state as CustomerProformaFormLoaded;
    final formIsNotEmpty = [
      // proformaDateController,
      if (!state.isGenerateAutoProformaNumber) proformaNumberController,
      customerIdController,
      // taxIdController,
      portsController,
      // delivaryTermsController,
      paymentTermsController,
      bankIdController,
      // notesController,
    ].every((controller) => controller.text.isNotEmpty && state.goodDescriptionsList.isNotEmpty);

    if (state.updatedMode) {
      final initialgoodsDescription =
          state.proforma!.goodsDescriptions.map((e) => ProformaGoodDescriptionDto.fromEntity(e)).toList();

      bool isGoodsDescriptionChanged = !Set.from(initialgoodsDescription).containsAll(state.goodDescriptionsList) ||
          !Set.from(state.goodDescriptionsList).containsAll(initialgoodsDescription);

      final proforma = state.proforma!;
      bool isFormChanged = proforma.proformaNumber != proformaNumberController.text ||
          proforma.date.formattedDateYYYYMMDD != proformaDateController.text ||
          proforma.customer.id.toString() != customerIdController.text ||
          proforma.taxId != taxIdController.text ||
          proforma.ports != portsController.text ||
          proforma.deliveryTerms != delivaryTermsController.text ||
          proforma.paymentTerms != paymentTermsController.text ||
          proforma.bankAccount.id.toString() != bankIdController.text ||
          proforma.notes != notesController.text ||
          isGoodsDescriptionChanged;

      emit(state.copyWith(
        saveEnabled: formIsNotEmpty && isFormChanged,
        cancelEnabled: isFormChanged,
        clearEnabled: formIsNotEmpty,
        proformaPdfDto: formIsNotEmpty ? mapFormDataToInvoicePdfDto() : null,
      ));
    } else {
      emit(state.copyWith(
        saveEnabled: formIsNotEmpty,
        cancelEnabled: false,
        clearEnabled: formIsNotEmpty,
      ));
    }
  }

  _clearGoodDescriptionForm() {
    descriptionController.clear();
    containersCountController.clear();
    weightController.clear();
    unitPriceController.clear();
    packingController.clear();
    totalPriceController.clear();
  }

  addGoodDescription() {
    final state = this.state as CustomerProformaFormLoaded;

    if (state.goodDescriptionsList.length >= 5) {
      emit(
        state.copyWith(
          loading: true,
          failureOrSuccessOption: some(
            left(const GeneralFailure(message: 'You cannot add more than 5 good descriptions')),
          ),
        ),
      );
      emit(state.copyWith(loading: false));
      return;
    }

    final goodDescription = ProformaGoodDescriptionDto(
      description: descriptionController.text,
      containersCount: int.parse(containersCountController.text),
      weight: double.parse(weightController.text),
      unitPrice: double.parse(unitPriceController.text),
      packing: packingController.text,
      uniqueKey: state.goodDescriptionsList.length.toString(),
    );
    emit(state.copyWith(descriptionList: [...state.goodDescriptionsList, goodDescription]));
    _clearGoodDescriptionForm();
    _onProformaFormChanged();
  }

  removeGoodDescription(ProformaGoodDescriptionDto dto) {
    final state = this.state as CustomerProformaFormLoaded;
    final updatedList = List.of(state.goodDescriptionsList)..remove(dto);
    emit(state.copyWith(descriptionList: updatedList));
    _onProformaFormChanged();
  }

  cancelProformaFormEvent() => _initializeControllers();
  @override
  Future<void> close() {
    proformaNumberController.dispose();
    proformaDateController.dispose();
    customerIdController.dispose();
    taxIdController.dispose();
    portsController.dispose();
    delivaryTermsController.dispose();
    paymentTermsController.dispose();
    bankIdController.dispose();
    notesController.dispose();
    return super.close();
  }

  Future createProforma() async {
    final state = this.state as CustomerProformaFormLoaded;

    final isFormValid = formKey.currentState!.validate();

    if (!isFormValid) {
      scrollController.jumpTo(0);
      return;
    }
    emit(state.copyWith(loading: true));

    final params = CreateCustomerProformaUseCaseParams(
      proformaNumber: state.isGenerateAutoProformaNumber ? null : proformaNumberController.text,
      date: proformaDateController.text,
      customerId: int.parse(customerIdController.text),
      taxId: taxIdController.text,
      ports: portsController.text,
      deliveryTerms: delivaryTermsController.text,
      descriptions: state.goodDescriptionsList,
      paymentTerms: paymentTermsController.text,
      bankAccountId: int.parse(bankIdController.text),
      notes: notesController.text,
    );

    final either = await createProformaUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          proforma: state.proforma,
        )),
      ),
      (proforma) {
        emit(state.copyWith(proforma: proforma, failureOrSuccessOption: some(right('Proforma created'))));
      },
    );
  }

  Future updateProforma() async {
    final state = this.state as CustomerProformaFormLoaded;

    emit(state.copyWith(loading: true));
    final params = UpdateCustomerProformaUseCaseParams(
      id: state.proforma!.id,
      proformaNumber: proformaNumberController.text,
      date: proformaDateController.text,
      customerId: int.parse(customerIdController.text),
      taxId: taxIdController.text,
      ports: portsController.text,
      deliveryTerms: delivaryTermsController.text,
      descriptions: state.goodDescriptionsList,
      paymentTerms: paymentTermsController.text,
      bankAccountId: int.parse(bankIdController.text),
      notes: notesController.text,
    );

    final either = await updateProformaUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (proforma) {
        emit(state.copyWith(proforma: proforma, failureOrSuccessOption: some(right('Proforma updated'))));
        _initializeControllers();
      },
    );
  }

  updateGoodDescription(ProformaGoodDescriptionDto dto) {
    final state = this.state as CustomerProformaFormLoaded;
    final index = state.goodDescriptionsList.indexWhere((element) => element.uniqueKey == dto.uniqueKey);

    if (index != -1) {
      final updatedList = List.of(state.goodDescriptionsList);
      updatedList[index] = dto;
      emit(state.copyWith(descriptionList: updatedList));
      _onProformaFormChanged();
    }
  }

  cancelChanges() {
    final state = this.state as CustomerProformaFormLoaded;
    final goodsDescriptions =
        state.proforma?.goodsDescriptions.map((e) => ProformaGoodDescriptionDto.fromEntity(e)).toList() ?? [];
    emit(CustomerProformaFormLoaded(
      goodDescriptionsList: goodsDescriptions,
    ));
    _initializeControllers();
  }

  toggleGenerateAutoProformaNumber() {
    final state = this.state as CustomerProformaFormLoaded;
    emit(state.copyWith(isGenerateAutoProformaNumber: !state.isGenerateAutoProformaNumber));
  }

  handleError() async {
    if (state is CustomerProformaFormError) {
      final state = this.state as CustomerProformaFormError;
      emit(CustomerProformaFormInitial());
      await Future.delayed(const Duration(milliseconds: 300));
      init(proformaId: state.id);
    }
  }

  ProformaPdfDto? mapFormDataToInvoicePdfDto() {
    final state = this.state as CustomerProformaFormLoaded;

    return ProformaPdfDto(
      bankName: bankNameController.text,
      customerAddress: customerAddressController.text,
      swift: swiftCodeController.text,
      customerName: customerNameController.text,
      delivartLocation: portsController.text,
      delivaryTerms: delivaryTermsController.text,
      paymentTerms: paymentTermsController.text,
      proformaDate: DateTime.tryParse(proformaDateController.text).orDefault,
      taxId: taxIdController.text,
      accountNumber: bankAccountNumberController.text,
      descriptions: state.goodDescriptionsList,
      proformaNumber: proformaNumberController.text,
    );
  }
}
