import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/deal_bill_entity.dart';
import '../../../domin/use_cases/create_deal_bill_use_case.dart';
import '../../../domin/use_cases/update_deal_bill_use_case.dart';

part 'deal_bill_form_event.dart';
part 'deal_bill_form_state.dart';

@injectable
class DealBillFormBloc extends Bloc<DealBillFormEvent, DealBillFormState> {
  final CreateDealBillUseCase createDealBillUsecase;
  final UpdateDealBillUseCase updateDealBillUsecase;
  DealBillFormBloc(
    this.createDealBillUsecase,
    this.updateDealBillUsecase,
  ) : super(DealBillInfoInitial()) {
    on<DealBillFormEvent>(_mapEvents);
  }

  _mapEvents(DealBillFormEvent event, Emitter<DealBillFormState> emit) async {
    if (event is InitialDealBillFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitDealBillFormEvent) {
      await _onSubmitDealBill(event, emit);
    }
    if (event is UpdateDealBillFormEvent) {
      await _onUpdateDealBill(event, emit);
    }
    if (event is CreateDealBillFormEvent) {
      await _onCreateDealBill(event, emit);
    }

    if (event is DealBillFormChangedEvent) {
      await _onDealBillFormChanged(event, emit);
    }
    if (event is CancelDealBillFormEvent) {
      await _onCancelDealBillFormEvent(event, emit);
    }
    if (event is ClearDealBillFormEvent) {
      await _onClearDealBillForm(event, emit);
    }
    if (event is PickAttachmentEvent) {
      await _onPickAttachment(event, emit);
    }

    if (event is ClearAttachmentEvent) {
      await _onClearAttachment(event, emit);
    }
  }

  final formKey = GlobalKey<FormState>();

  final vendorController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  final dateController = TextEditingController();

  _initial(InitialDealBillFormEvent event, Emitter<DealBillFormState> emit) {
    final attachment = event.dealBill?.attachmentUrl;
    emit(DealBillFormLoaded(
      dealId: event.dealId,
      dealBill: event.dealBill,
      updatedMode: event.dealBill != null,
      attachmentUrl: attachment?.isNotEmpty == true ? some(attachment!) : none(),
    ));
    _initializeControllers();
  }

  _initializeControllers() {
    final state = this.state as DealBillFormLoaded;
    formKey.currentState?.reset();
    vendorController.text = state.dealBill?.vendor ?? '';
    amountController.text = state.dealBill?.amount.toString() ?? '';
    notesController.text = state.dealBill?.notes ?? '';
    dateController.text = state.dealBill?.date.formattedDateYYYYMMDD ?? DateTime.now().formattedDateYYYYMMDD;

    setupControllersListeners();
    add(DealBillFormChangedEvent());
  }

  setupControllersListeners() {
    for (var element in [
      vendorController,
      amountController,
      notesController,
      dateController,
    ]) {
      element.addListener(() => add(DealBillFormChangedEvent()));
    }
  }

  _onDealBillFormChanged(DealBillFormChangedEvent event, Emitter<DealBillFormState> emit) {
    final state = this.state as DealBillFormLoaded;
    final formIsNotEmpty = [
      amountController.text.isNotEmpty,
    ].every((element) => element);

    final isAnyFieldIsNotEmpty = [
      amountController.text.isNotEmpty,
      state.pickedAttachment.isSome(),
    ].any((element) => element);

    if (state.updatedMode) {
      final dealBill = state.dealBill!;
      final urlChanged = state.attachmentUrl.fold(
        () => dealBill.attachmentUrl.isNotEmpty,
        (a) => a != dealBill.attachmentUrl,
      );
      bool isFormChanged = vendorController.text != dealBill.vendor ||
          amountController.text != dealBill.amount.toString() ||
          notesController.text != dealBill.notes ||
          dateController.text != dealBill.date.formattedDateYYYYMMDD ||
          state.pickedAttachment.isSome() ||
          urlChanged;

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

  _onSubmitDealBill(SubmitDealBillFormEvent event, Emitter<DealBillFormState> emit) {
    final state = this.state as DealBillFormLoaded;
    if (formKey.currentState?.validate() == false) return;
    if (state.updatedMode) {
      add(UpdateDealBillFormEvent());
    } else {
      add(CreateDealBillFormEvent());
    }
  }

  Future _onCreateDealBill(CreateDealBillFormEvent event, Emitter<DealBillFormState> emit) async {
    final state = this.state as DealBillFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateDealBillUseCaseParams(
      dealId: state.dealId,
      vendor: vendorController.text,
      amount: double.tryParse(amountController.text).toDoubleOrZero,
      notes: notesController.text,
      date: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
    );

    final either = await createDealBillUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          dealBill: state.dealBill,
        )),
      ),
      (dealBill) {
        emit(state.copyWith(dealBill: dealBill, failureOrSuccessOption: some(right('Bill created'))));
      },
    );
  }

  Future _onUpdateDealBill(UpdateDealBillFormEvent event, Emitter<DealBillFormState> emit) async {
    final state = this.state as DealBillFormLoaded;

    final deleteAttachment = state.attachmentUrl.isNone() && state.pickedAttachment.isNone();
    final parms = UpdateDealBillUseCaseParams(
      amount: double.tryParse(amountController.text).toDoubleOrZero,
      vendor: vendorController.text,
      notes: notesController.text,
      date: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      id: state.dealBill!.id,
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
      deleteAttachemnt: deleteAttachment,
      dealId: state.dealId,
    );

    emit(state.copyWith(loading: true));
    final either = await updateDealBillUsecase.call(parms);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (dealBill) {
        emit(state.copyWith(dealBill: dealBill, failureOrSuccessOption: some(right('Bill updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearDealBillForm(ClearDealBillFormEvent event, Emitter<DealBillFormState> emit) {
    formKey.currentState?.reset();

    vendorController.clear();
    amountController.clear();
    notesController.clear();
    dateController.clear();

    if (state is DealBillFormLoaded) {
      final state = this.state as DealBillFormLoaded;
      emit(state.copyWith(pickedAttachment: none(), attachmentUrl: none()));
    }
  }

  _onCancelDealBillFormEvent(DealBillFormEvent event, Emitter<DealBillFormState> emit) {
    final state = this.state as DealBillFormLoaded;
    add(InitialDealBillFormEvent(dealBill: state.dealBill, dealId: state.dealId));
  }

  @override
  Future<void> close() {
    vendorController.dispose();
    amountController.dispose();
    notesController.dispose();
    dateController.dispose();
    return super.close();
  }

  _onPickAttachment(PickAttachmentEvent event, Emitter<DealBillFormState> emit) async {
    final state = this.state as DealBillFormLoaded;
    emit(state.copyWith(pickedAttachment: some(event.file)));
    add(DealBillFormChangedEvent());
  }

  _onClearAttachment(ClearAttachmentEvent event, Emitter<DealBillFormState> emit) {
    final state = this.state as DealBillFormLoaded;
    emit(
      state.copyWith(
        pickedAttachment: none(),
        attachmentUrl: none(),
      ),
    );
    add(DealBillFormChangedEvent());
  }
}
