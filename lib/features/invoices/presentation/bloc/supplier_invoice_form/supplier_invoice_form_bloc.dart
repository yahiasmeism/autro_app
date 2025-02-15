import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/features/invoices/domin/use_cases/get_supplier_invoice_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/supplier_invoice_entity.dart';
import '../../../domin/use_cases/create_supplier_invoice_use_case.dart';
import '../../../domin/use_cases/update_supplier_invoice_use_case.dart';

part 'supplier_invoice_form_event.dart';
part 'supplier_invoice_form_state.dart';

@injectable
class SupplierInvoiceFormBloc extends Bloc<SupplierInvoiceFormEvent, SupplierInvoiceFormState> {
  final CreateSupplierInvoiceUseCase createSupplierInvoiceUsecase;
  final UpdateSupplierInvoiceUseCase updateSupplierInvoiceUsecase;
  final GetSupplierInvoiceUseCase getSupplierInvoiceUseCase;
  SupplierInvoiceFormBloc(
    this.createSupplierInvoiceUsecase,
    this.updateSupplierInvoiceUsecase,
    this.getSupplierInvoiceUseCase,
  ) : super(SupplierInvoiceInfoInitial()) {
    on<SupplierInvoiceFormEvent>(_mapEvents);
  }

  _mapEvents(SupplierInvoiceFormEvent event, Emitter<SupplierInvoiceFormState> emit) async {
    if (event is InitialSupplierInvoiceFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitSupplierInvoiceFormEvent) {
      await _onSubmitSupplierInvoice(event, emit);
    }
    if (event is UpdateSupplierInvoiceFormEvent) {
      await _onUpdateSupplierInvoice(event, emit);
    }
    if (event is CreateSupplierInvoiceFormEvent) {
      await _onCreateSupplierInvoice(event, emit);
    }

    if (event is SupplierInvoiceFormChangedEvent) {
      await _onSupplierInvoiceFormChanged(event, emit);
    }
    if (event is CancelSupplierInvoiceFormEvent) {
      await _onCancelSupplierInvoiceFormEvent(event, emit);
    }
    if (event is ClearSupplierInvoiceFormEvent) {
      await _onClearSupplierInvoiceForm(event, emit);
    }
    if (event is PickAttachmentEvent) {
      await _onPickAttachment(event, emit);
    }

    if (event is ClearAttachmentEvent) {
      await _onClearAttachment(event, emit);
    }

    if (event is SupplierInvoiceHandleError) {
      await _onHandleError(event, emit);
    }
  }

  /* 
  
    final int id;
  final String number;
  final int supplierId;
  final int dealId;
  final double totalAmount;
  final String attachmentUrl;
  final DateTime date;
  final String material;
  final SupplierEntity supplier;
   */

  final formKey = GlobalKey<FormState>();
  final dealIdController = TextEditingController();
  final dealNumberController = TextEditingController();
  final supplierNameController = TextEditingController();
  final supplierIdController = TextEditingController();
  final totalAmountController = TextEditingController();
  final typeMaterialNameController = TextEditingController();
  final statusController = TextEditingController();
  final dateController = TextEditingController();

  _initial(InitialSupplierInvoiceFormEvent event, Emitter<SupplierInvoiceFormState> emit) async {
    if (event.id != null) {
      final either = await getSupplierInvoiceUseCase.call(event.id!);
      either.fold(
        (failure) {
          emit(SupplierInvoiceFormError(failure: failure, id: event.id!));
        },
        (invoice) {
          emit(SupplierInvoiceFormLoaded(
            supplierInvoice: invoice,
            updatedMode: true,
            attachmentUrl: invoice.attachmentUrl.isNotEmpty == true ? some(invoice.attachmentUrl) : none(),
          ));
        },
      );
    } else {
      emit(const SupplierInvoiceFormLoaded());
    }

    _initializeControllers();
  }

  _initializeControllers() {
    if (state is SupplierInvoiceFormLoaded) {
      final state = this.state as SupplierInvoiceFormLoaded;
      formKey.currentState?.reset();
      dealIdController.text = state.supplierInvoice?.dealId.toString() ?? '';
      dealNumberController.text = state.supplierInvoice?.number ?? '';
      supplierNameController.text = state.supplierInvoice?.supplier.name ?? '';
      supplierIdController.text = state.supplierInvoice?.supplier.id.toString() ?? '';
      totalAmountController.text = state.supplierInvoice?.totalAmount.toString() ?? '';
      typeMaterialNameController.text = state.supplierInvoice?.material ?? '';
      dateController.text = state.supplierInvoice?.date.formattedDateYYYYMMDD ?? DateTime.now().formattedDateYYYYMMDD;
      statusController.text = state.supplierInvoice?.status.capitalized ?? 'Pending';
      setupControllersListeners();
      add(SupplierInvoiceFormChangedEvent());
    }
  }

  setupControllersListeners() {
    for (var controller in [
      dealIdController,
      dealNumberController,
      supplierNameController,
      supplierIdController,
      totalAmountController,
      typeMaterialNameController,
      dateController,
      statusController,
    ]) {
      controller.addListener(() => add(SupplierInvoiceFormChangedEvent()));
    }
  }

  _onSupplierInvoiceFormChanged(SupplierInvoiceFormChangedEvent event, Emitter<SupplierInvoiceFormState> emit) {
    final state = this.state as SupplierInvoiceFormLoaded;
    final formIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      dealNumberController.text.isNotEmpty,
      supplierNameController.text.isNotEmpty,
      supplierIdController.text.isNotEmpty,
      totalAmountController.text.isNotEmpty,
      dateController.text.isNotEmpty,
      statusController.text.isNotEmpty,
    ].every((element) => element);

    final isAnyFieldIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      dealNumberController.text.isNotEmpty,
      supplierNameController.text.isNotEmpty,
      supplierIdController.text.isNotEmpty,
      totalAmountController.text.isNotEmpty,
      typeMaterialNameController.text.isNotEmpty,
      dateController.text.isNotEmpty,
      state.pickedAttachment.isSome(),
      statusController.text.isNotEmpty,
    ].any((element) => element);

    if (state.updatedMode) {
      final supplierInvoice = state.supplierInvoice!;
      final urlChanged = state.attachmentUrl.fold(
        () => supplierInvoice.attachmentUrl.isNotEmpty,
        (a) => a != supplierInvoice.attachmentUrl,
      );
      bool isFormChanged = supplierInvoice.dealId != int.tryParse(dealIdController.text) ||
          supplierInvoice.number != dealNumberController.text ||
          supplierInvoice.supplier.name != supplierNameController.text ||
          supplierInvoice.supplier.id != int.tryParse(supplierIdController.text) ||
          supplierInvoice.totalAmount != double.tryParse(totalAmountController.text) ||
          supplierInvoice.material != typeMaterialNameController.text ||
          supplierInvoice.date.formattedDateYYYYMMDD != dateController.text ||
          state.pickedAttachment.isSome() ||
          urlChanged ||
          supplierInvoice.status.capitalized != statusController.text;

      emit(state.copyWith(
        saveEnabled: formIsNotEmpty && isFormChanged,
        cancelEnabled: isFormChanged,
        clearEnabled: formIsNotEmpty,
      ));
    } else {
      emit(state.copyWith(
        saveEnabled: formIsNotEmpty,
        cancelEnabled: false,
        clearEnabled: isAnyFieldIsNotEmpty,
      ));
    }
  }

  _onSubmitSupplierInvoice(SubmitSupplierInvoiceFormEvent event, Emitter<SupplierInvoiceFormState> emit) {
    final state = this.state as SupplierInvoiceFormLoaded;
    if (formKey.currentState?.validate() == false) return;
    if (state.updatedMode) {
      add(UpdateSupplierInvoiceFormEvent());
    } else {
      add(CreateSupplierInvoiceFormEvent());
    }
  }

  Future _onCreateSupplierInvoice(CreateSupplierInvoiceFormEvent event, Emitter<SupplierInvoiceFormState> emit) async {
    final state = this.state as SupplierInvoiceFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateSupplierInvoiceUseCaseParams(
      status: statusController.text,
      material: typeMaterialNameController.text,
      supplierId: int.tryParse(supplierIdController.text).toIntOrZero,
      totalAmount: double.tryParse(totalAmountController.text).toDoubleOrZero,
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      date: DateTime.tryParse(dateController.text).orDefault,
      attachementPath: state.pickedAttachment.fold(() => null, (file) => file.path),
    );

    final either = await createSupplierInvoiceUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          supplierInvoice: state.supplierInvoice,
        )),
      ),
      (supplierInvoice) {
        emit(state.copyWith(supplierInvoice: supplierInvoice, failureOrSuccessOption: some(right('Supplier Invoice created'))));
      },
    );
  }

  Future _onUpdateSupplierInvoice(UpdateSupplierInvoiceFormEvent event, Emitter<SupplierInvoiceFormState> emit) async {
    final state = this.state as SupplierInvoiceFormLoaded;

    final deleteAttachment = state.attachmentUrl.isNone() && state.pickedAttachment.isNone();
    final parms = UpdateSupplierInvoiceUseCaseParams(
      status: statusController.text,
      date: DateTime.tryParse(dateController.text).orDefault,
      material: typeMaterialNameController.text,
      supplierId: int.tryParse(supplierIdController.text).toIntOrZero,
      totalAmount: int.tryParse(totalAmountController.text).toDoubleOrZero,
      id: state.supplierInvoice!.id,
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      attachementPath: state.pickedAttachment.fold(() => null, (file) => file.path),
      deleteAttachment: deleteAttachment,
    );

    emit(state.copyWith(loading: true));
    final either = await updateSupplierInvoiceUsecase.call(parms);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (supplierInvoice) {
        emit(state.copyWith(supplierInvoice: supplierInvoice, failureOrSuccessOption: some(right('Supplier Invoice updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearSupplierInvoiceForm(ClearSupplierInvoiceFormEvent event, Emitter<SupplierInvoiceFormState> emit) {
    formKey.currentState?.reset();
    dealIdController.clear();
    dealNumberController.clear();
    supplierNameController.clear();
    supplierIdController.clear();
    totalAmountController.clear();
    typeMaterialNameController.clear();
    dateController.clear();
    statusController.text = 'Pending';

    if (state is SupplierInvoiceFormLoaded) {
      final state = this.state as SupplierInvoiceFormLoaded;
      emit(state.copyWith(pickedAttachment: none(), attachmentUrl: none()));
    }
  }

  _onCancelSupplierInvoiceFormEvent(SupplierInvoiceFormEvent event, Emitter<SupplierInvoiceFormState> emit) {
    final state = this.state as SupplierInvoiceFormLoaded;
    final invoice = state.supplierInvoice;
    if (invoice != null) {
      emit(state.copyWith(
        pickedAttachment: none(),
        attachmentUrl: some(invoice.attachmentUrl),
      ));
    }
    _initializeControllers();
  }

  @override
  Future<void> close() {
    dealIdController.dispose();
    dealNumberController.dispose();
    supplierNameController.dispose();
    supplierIdController.dispose();
    totalAmountController.dispose();
    typeMaterialNameController.dispose();
    statusController.dispose();
    dateController.dispose();
    return super.close();
  }

  _onPickAttachment(PickAttachmentEvent event, Emitter<SupplierInvoiceFormState> emit) async {
    final state = this.state as SupplierInvoiceFormLoaded;
    emit(state.copyWith(pickedAttachment: some(event.file)));
    add(SupplierInvoiceFormChangedEvent());
  }

  _onClearAttachment(ClearAttachmentEvent event, Emitter<SupplierInvoiceFormState> emit) {
    final state = this.state as SupplierInvoiceFormLoaded;
    emit(
      state.copyWith(
        pickedAttachment: none(),
        attachmentUrl: none(),
      ),
    );
    add(SupplierInvoiceFormChangedEvent());
  }

  _onHandleError(SupplierInvoiceHandleError event, Emitter<SupplierInvoiceFormState> emit) async {
    if (state is SupplierInvoiceFormError) {
      final state = this.state as SupplierInvoiceFormError;

      emit(SupplierInvoiceInfoInitial());

      await Future.delayed(const Duration(milliseconds: 300));

      add(InitialSupplierInvoiceFormEvent(id: state.id));
    }
  }
}
