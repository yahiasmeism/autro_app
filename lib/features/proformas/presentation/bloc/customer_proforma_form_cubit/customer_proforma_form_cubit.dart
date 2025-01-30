import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/proformas/domin/dtos/proforma_good_description_dto.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/use_cases/create_customer_proforma_use_case.dart';
import '../../../domin/use_cases/update_customer_proforma_use_case.dart';

part 'customer_proforma_form_state.dart';

@injectable
class ProformaFormCubit extends Cubit<CustomerProformaFormState> {
  final CreateCustomerProformaUseCase createProformaUsecase;
  final UpdateCustomerProformaUseCase updateProformaUsecase;
  ProformaFormCubit(this.createProformaUsecase, this.updateProformaUsecase) : super(CustomerProformaFormInitial());

  // Goods Descriptions
  final descriptionController = TextEditingController();
  final containersCountController = TextEditingController();
  final weightController = TextEditingController();
  final unitPriceController = TextEditingController();
  final packingController = TextEditingController();
  final totalPriceController = TextEditingController();

  // Proforma
  final formKey = GlobalKey<FormState>();
  final proformaNumberController = TextEditingController();
  final proformaDateController = TextEditingController();
  final customerIdController = TextEditingController();
  final customerNameController = TextEditingController();
  final taxIdController = TextEditingController();
  final portsController = TextEditingController();
  final delivaryTermsController = TextEditingController();
  final paymentTermsController = TextEditingController();
  final bankIdController = TextEditingController();
  final bankNameController = TextEditingController();
  final notesController = TextEditingController();

  Future init({required CustomerProformaEntity? proforma}) async {
    final goodsDescriptions = proforma?.goodsDescriptions.map((e) => ProformaGoodDescriptionDto.fromEntity(e)).toList() ?? [];
    emit(CustomerProformaFormLoaded(
      proforma: proforma,
      goodDescriptionsList: goodsDescriptions,
      updatedMode: proforma != null,
    ));
    await _initializeControllers();
  }

  _initializeControllers() {
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
    bankNameController.text = state.proforma?.bankAccount.formattedLabel ?? '';
    notesController.text = state.proforma?.notes ?? '';

    _setupControllersListeners();
    _onProformaFormChanged();
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
      proformaNumberController,
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
    emit(state.copyWith(loading: true));

    final params = CreateCustomerProformaUseCaseParams(
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
    init(proforma: state.proforma);
  }
}
