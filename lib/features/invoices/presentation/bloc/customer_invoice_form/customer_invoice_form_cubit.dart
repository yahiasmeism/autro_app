import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/invoices/domin/dtos/invoice_good_description_dto.dart';
import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/use_cases/create_customer_invoice_use_case.dart';
import '../../../domin/use_cases/update_customer_invoice_use_case.dart';

part 'customer_invoice_form_state.dart';

@injectable
class CustomerInvoiceFormCubit extends Cubit<CustomerInvoiceFormState> {
  final CreateCustomerInvoiceUseCase createInvoiceUsecase;
  final UpdateCustomerInvoiceUseCase updateInvoiceUsecase;
  CustomerInvoiceFormCubit(
    this.createInvoiceUsecase,
    this.updateInvoiceUsecase,
  ) : super(CustomerInvoiceFormInitial());

  // Goods Descriptions
  final descriptionController = TextEditingController();
  final containerNumberController = TextEditingController();
  final weightController = TextEditingController();
  final unitPriceController = TextEditingController();
  final totalPriceController = TextEditingController();

  // Invoice
  final formKey = GlobalKey<FormState>();
  final invoiceNumberController = TextEditingController();
  final invoiceDateController = TextEditingController();
  final customerIdController = TextEditingController();
  final customerNameController = TextEditingController();
  final taxIdController = TextEditingController();
  final bankIdController = TextEditingController();
  final bankNameController = TextEditingController();
  final notesController = TextEditingController();
  final proformaNameController = TextEditingController();
  final dealSeriesNumberController = TextEditingController();
  final dealIdController = TextEditingController();

  Future init({required CustomerInvoiceEntity? invoice}) async {
    final goodsDescriptions = invoice?.goodsDescriptions.map((e) => InvoiceGoodDescriptionDto.fromEntity(e)).toList() ?? [];
    emit(CustomerInvoiceFormLoaded(
      invoice: invoice,
      goodDescriptionsList: goodsDescriptions,
      updatedMode: invoice != null,
    ));
    await _initializeControllers();
  }

  _initializeControllers() {
    final state = this.state as CustomerInvoiceFormLoaded;
    formKey.currentState?.reset();
    invoiceNumberController.text = state.invoice?.invoiceNumber ?? '';
    invoiceDateController.text = state.invoice?.date.formattedDateYYYYMMDD ?? DateTime.now().formattedDateYYYYMMDD;
    customerIdController.text = state.invoice?.customer.id.toString() ?? '';
    customerNameController.text = state.invoice?.customer.name ?? '';
    taxIdController.text = state.invoice?.taxId ?? '';
    bankIdController.text = state.invoice?.bankAccount.id.toString() ?? '';
    bankNameController.text = state.invoice?.bankAccount.formattedLabel ?? '';
    notesController.text = state.invoice?.notes ?? '';
    dealIdController.text = state.invoice?.dealId.toString() ?? '';
    dealSeriesNumberController.text = state.invoice?.formattedSeriesNumber ?? '';
    _setupControllersListeners();
    _onInvoiceFormChanged();
  }

  _setupControllersListeners() {
    // Invoice
    for (var controller in [
      invoiceNumberController,
      invoiceDateController,
      customerIdController,
      taxIdController,
      bankIdController,
      notesController,
      dealIdController,
      dealSeriesNumberController,
    ]) {
      controller.addListener(() => _onInvoiceFormChanged());
    }
    // Goods Descriptions
    for (var controller in [
      descriptionController,
      containerNumberController,
      weightController,
      unitPriceController,
      totalPriceController,
    ]) {
      controller.addListener(() => _onGoodDescriptionInputChanged());
    }
  }

  _onGoodDescriptionInputChanged() {
    final addGoodDescriptionIsActive = [
      descriptionController,
      containerNumberController,
      weightController,
      unitPriceController,
      totalPriceController,
    ].every((controller) => controller.text.isNotEmpty);

    final state = this.state as CustomerInvoiceFormLoaded;
    emit(state.copyWith(addGoodDescriptionEnabled: addGoodDescriptionIsActive));

    // Calculate total price
    final weight = double.tryParse(weightController.text) ?? 0;
    final unitPrice = double.tryParse(unitPriceController.text) ?? 0;
    final totalPrice = weight * unitPrice;
    totalPriceController.text = totalPrice.toStringAsFixed(2);
  }

  _onInvoiceFormChanged() {
    final state = this.state as CustomerInvoiceFormLoaded;
    final formIsNotEmpty = [
      invoiceNumberController,
      customerIdController,
      bankIdController,
    ].every((controller) => controller.text.isNotEmpty && state.goodDescriptionsList.isNotEmpty);

    if (state.updatedMode) {
      final initialgoodsDescription =
          state.invoice!.goodsDescriptions.map((e) => InvoiceGoodDescriptionDto.fromEntity(e)).toList();

      bool isGoodsDescriptionChanged = !Set.from(initialgoodsDescription).containsAll(state.goodDescriptionsList) ||
          !Set.from(state.goodDescriptionsList).containsAll(initialgoodsDescription);

      final invoice = state.invoice!;
      bool isFormChanged = invoice.invoiceNumber != invoiceNumberController.text ||
          invoice.date.formattedDateYYYYMMDD != invoiceDateController.text ||
          invoice.customer.id.toString() != customerIdController.text ||
          invoice.taxId != taxIdController.text ||
          invoice.bankAccount.id.toString() != bankIdController.text ||
          invoice.notes != notesController.text ||
          invoice.dealId.toString() != dealIdController.text ||
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
    containerNumberController.clear();
    weightController.clear();
    unitPriceController.clear();
    totalPriceController.clear();
  }

  addGoodDescription() {
    final state = this.state as CustomerInvoiceFormLoaded;
    final goodDescription = InvoiceGoodDescriptionDto(
      containerNumber: containerNumberController.text,
      description: descriptionController.text,
      weight: double.parse(weightController.text),
      unitPrice: double.parse(unitPriceController.text),
      uniqueKey: state.goodDescriptionsList.length.toString(),
    );
    emit(state.copyWith(descriptionList: [...state.goodDescriptionsList, goodDescription]));
    _clearGoodDescriptionForm();
    _onInvoiceFormChanged();
  }

  removeGoodDescription(InvoiceGoodDescriptionDto dto) {
    final state = this.state as CustomerInvoiceFormLoaded;
    final updatedList = List.of(state.goodDescriptionsList)..remove(dto);
    emit(state.copyWith(descriptionList: updatedList));
    _onInvoiceFormChanged();
  }

  cancelInvoiceFormEvent() => _initializeControllers();
  @override
  Future<void> close() {
    invoiceNumberController.dispose();
    invoiceDateController.dispose();
    customerIdController.dispose();
    taxIdController.dispose();
    bankIdController.dispose();
    notesController.dispose();
    return super.close();
  }

  Future createInvoice() async {
    final state = this.state as CustomerInvoiceFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateCustomerInvoiceUseCaseParams(
      dealId: int.parse(dealIdController.text),
      invoiceNumber: invoiceNumberController.text,
      date: invoiceDateController.text,
      customerId: int.parse(customerIdController.text),
      taxId: taxIdController.text,
      descriptions: state.goodDescriptionsList,
      bankAccountId: int.parse(bankIdController.text),
      notes: notesController.text,
    );

    final either = await createInvoiceUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          invoice: state.invoice,
        )),
      ),
      (invoice) {
        emit(state.copyWith(invoice: invoice, failureOrSuccessOption: some(right('Invoice created'))));
      },
    );
  }

  Future updateInvoice() async {
    final state = this.state as CustomerInvoiceFormLoaded;

    emit(state.copyWith(loading: true));
    final params = UpdateCustomerInvoiceUseCaseParams(
      id: state.invoice!.id,
      invoiceNumber: invoiceNumberController.text,
      date: invoiceDateController.text,
      customerId: int.parse(customerIdController.text),
      taxId: taxIdController.text,
      descriptions: state.goodDescriptionsList,
      bankAccountId: int.parse(bankIdController.text),
      notes: notesController.text,
      dealId: int.parse(dealIdController.text),
    );

    final either = await updateInvoiceUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (invoice) {
        emit(state.copyWith(invoice: invoice, failureOrSuccessOption: some(right('Invoice updated'))));
        _initializeControllers();
      },
    );
  }

  updateGoodDescription(InvoiceGoodDescriptionDto dto) {
    final state = this.state as CustomerInvoiceFormLoaded;
    final index = state.goodDescriptionsList.indexWhere((element) => element.uniqueKey == dto.uniqueKey);

    if (index != -1) {
      final updatedList = List.of(state.goodDescriptionsList);
      updatedList[index] = dto;
      emit(state.copyWith(descriptionList: updatedList));
      _onInvoiceFormChanged();
    }
  }

  cancelChanges() {
    final state = this.state as CustomerInvoiceFormLoaded;
    init(invoice: state.invoice);
  }
}
