import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/bills/domin/entities/bill_entity.dart';
import 'package:autro_app/features/bills/domin/use_cases/add_bill_use_case.dart';
import 'package:autro_app/features/bills/domin/use_cases/get_bill_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/use_cases/update_bill_use_case.dart';

part 'bill_form_event.dart';
part 'bill_form_state.dart';

@injectable
class BillFormBloc extends Bloc<BillFormEvent, BillFormState> {
  final AddBillUseCase addBillUsecase;
  final GetBillUseCase getBillUseCase;
  final UpdateBillUseCase updateBillUsecase;
  BillFormBloc(
    this.addBillUsecase,
    this.getBillUseCase,
    this.updateBillUsecase,
  ) : super(BillInfoInitial()) {
    on<BillFormEvent>(_mapEvents);
  }

  _mapEvents(BillFormEvent event, Emitter<BillFormState> emit) async {
    if (event is InitialBillFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitBillFormEvent) {
      await _onSubmitBill(event, emit);
    }
    if (event is UpdateBillFormEvent) {
      await _onUpdateBill(event, emit);
    }
    if (event is CreateBillFormEvent) {
      await _onCreateBill(event, emit);
    }
    if (event is BillFormChangedEvent) {
      await _onBillFormChanged(event, emit);
    }
    if (event is CancelBillFormEvent) {
      await _onCancelBillFormEvent(event, emit);
    }
    if (event is ClearBillFormEvent) {
      await _onClearBillForm(event, emit);
    }
    if (event is BillFormHandleError) {
      await _onHandleError(event, emit);
    }
    if (event is PickAttachmentEvent) {
      await _onPickAttachment(event, emit);
    }
    if (event is RemoveAttachmentEvent) {
      await _onRemoveAttachmentEvent(event, emit);
    }
  }

  final vendorController = TextEditingController();
  final amountController = TextEditingController();
  final vatController = TextEditingController();
  final dateController = TextEditingController();
  final notesController = TextEditingController();
  final remainingAmountController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  _initial(InitialBillFormEvent event, Emitter<BillFormState> emit) async {
    if (event.billId != null) {
      final either = await getBillUseCase.call(event.billId!);
      either.fold(
        (failure) {
          emit(BillFormError(failure: failure, id: event.billId!));
        },
        (bill) {
          emit(BillFormLoaded(
            bill: bill,
            updatedMode: true,
            attachmentUrl: bill.attachmentUrl.isNotEmpty ? some(bill.attachmentUrl) : none(),
          ));
        },
      );
    } else {
      emit(const BillFormLoaded());
    }

    _initializeControllers();
  }

  _initializeControllers() {
    if (state is BillFormLoaded) {
      final state = this.state as BillFormLoaded;
      formKey.currentState?.reset();
      vendorController.text = state.bill?.vendor ?? '';
      amountController.text = state.bill?.amount.toString() ?? '';
      dateController.text = state.bill?.date.formattedDateYYYYMMDD ?? DateTime.now().formattedDateYYYYMMDD;
      notesController.text = state.bill?.notes ?? '';
      vatController.text = state.bill?.vat.toStringAsFixed(2) ?? '';

      setupControllersListeners();
      add(BillFormChangedEvent());
    }
  }

  setupControllersListeners() {
    vendorController.addListener(() => add(BillFormChangedEvent()));
    amountController.addListener(() => add(BillFormChangedEvent()));
    dateController.addListener(() => add(BillFormChangedEvent()));
    notesController.addListener(() => add(BillFormChangedEvent()));
    vatController.addListener(() => add(BillFormChangedEvent()));
  }

  _onBillFormChanged(BillFormChangedEvent event, Emitter<BillFormState> emit) {
    final state = this.state as BillFormLoaded;
    remainingAmountController.text =
        ((double.tryParse(amountController.text) ?? 0.0) - (double.tryParse(vatController.text) ?? 0.0)).toStringAsFixed(2);
    final formIsNotEmpty = vendorController.text.isNotEmpty && amountController.text.isNotEmpty && dateController.text.isNotEmpty;

    if (state.updatedMode) {
      final bill = state.bill!;
      final urlChanged = state.attachmentUrl.fold(
        () => bill.attachmentUrl.isNotEmpty,
        (a) => a != bill.attachmentUrl,
      );
      bool isFormChanged = bill.vendor != vendorController.text ||
          bill.amount != (double.tryParse(amountController.text) ?? 0) ||
          bill.date.formattedDateYYYYMMDD != dateController.text ||
          bill.notes != notesController.text ||
          bill.vat != (double.tryParse(vatController.text) ?? 0) ||
          urlChanged ||
          state.pickedAttachment.isSome();
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

  _onSubmitBill(SubmitBillFormEvent event, Emitter<BillFormState> emit) {
    final state = this.state as BillFormLoaded;
    if (formKey.currentState?.validate() == false) return;

    if (state.updatedMode) {
      add(UpdateBillFormEvent());
    } else {
      add(CreateBillFormEvent());
    }
  }

  Future _onCreateBill(CreateBillFormEvent event, Emitter<BillFormState> emit) async {
    final state = this.state as BillFormLoaded;

    if (formKey.currentState?.validate() == false) return;

    emit(state.copyWith(loading: true));

    final params = AddBillUseCaseParams(
      vat: double.tryParse(vatController.text) ?? 0,
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
      vendor: vendorController.text,
      amount: double.tryParse(amountController.text) ?? 0,
      date: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      notes: notesController.text,
    );

    final either = await addBillUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          bill: state.bill,
        )),
      ),
      (bill) {
        emit(state.copyWith(bill: bill, failureOrSuccessOption: some(right('Bill created'))));
      },
    );
  }

  Future _onUpdateBill(UpdateBillFormEvent event, Emitter<BillFormState> emit) async {
    final state = this.state as BillFormLoaded;
    if (formKey.currentState?.validate() == false) return;

    final deleteAttachment = state.attachmentUrl.isNone() && state.pickedAttachment.isNone();

    emit(state.copyWith(loading: true));
    final params = UpdateBillUseCaseParams(
      vat: double.tryParse(vatController.text) ?? 0,
      id: state.bill!.id,
      vendor: vendorController.text,
      amount: double.tryParse(amountController.text) ?? 0,
      date: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      notes: notesController.text,
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
      deleteAttachment: deleteAttachment,
    );
    final either = await updateBillUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (bill) {
        emit(state.copyWith(bill: bill, failureOrSuccessOption: some(right('Bill updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearBillForm(ClearBillFormEvent event, Emitter<BillFormState> emit) {
    formKey.currentState?.reset();
    vendorController.clear();
    amountController.clear();
    dateController.clear();
    notesController.clear();
    vatController.clear();
    if (state is BillFormLoaded) {
      final state = this.state as BillFormLoaded;
      emit(state.copyWith(pickedAttachment: none(), attachmentUrl: none()));
    }
  }

  _onCancelBillFormEvent(BillFormEvent event, Emitter<BillFormState> emit) {
    final state = this.state as BillFormLoaded;
    if (state.bill != null) {
      emit(
        state.copyWith(
          pickedAttachment: none(),
          attachmentUrl: some(state.bill!.attachmentUrl),
        ),
      );
    }
    return _initializeControllers();
  }

  @override
  Future<void> close() {
    vendorController.dispose();
    amountController.dispose();
    dateController.dispose();
    notesController.dispose();
    vatController.dispose();
    return super.close();
  }

  _onHandleError(BillFormHandleError event, Emitter<BillFormState> emit) async {
    if (state is BillFormError) {
      final state = this.state as BillFormError;
      emit(BillInfoInitial());
      await Future.delayed(const Duration(milliseconds: 300));
      add(InitialBillFormEvent(billId: state.id));
    }
  }

  _onPickAttachment(PickAttachmentEvent event, Emitter<BillFormState> emit) async {
    final state = this.state as BillFormLoaded;
    emit(state.copyWith(pickedAttachment: some(event.file)));
    add(BillFormChangedEvent());
  }

  _onRemoveAttachmentEvent(RemoveAttachmentEvent event, Emitter<BillFormState> emit) async {
    final state = this.state as BillFormLoaded;
    emit(state.copyWith(pickedAttachment: none(), attachmentUrl: none()));
    add(BillFormChangedEvent());
  }
}
