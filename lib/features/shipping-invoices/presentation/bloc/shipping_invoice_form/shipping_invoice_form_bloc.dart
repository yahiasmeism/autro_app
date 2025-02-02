import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/update_shipping_invoices_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/shipping_invoice_entity.dart';
import '../../../domin/usecases/create_shipping_invoice_use_case.dart';

part 'shipping_invoice_form_event.dart';
part 'shipping_invoice_form_state.dart';

@injectable
class ShippingInvoiceFormBloc extends Bloc<ShippingInvoiceFormEvent, ShippingInvoiceFormState> {
  final CreateShippingInvoiceUseCase createShippingInvoiceUsecase;
  final UpdateShippingInvoicesUseCase updateShippingInvoiceUsecase;
  ShippingInvoiceFormBloc(
    this.createShippingInvoiceUsecase,
    this.updateShippingInvoiceUsecase,
  ) : super(ShippingInvoiceInfoInitial()) {
    on<ShippingInvoiceFormEvent>(_mapEvents);
  }

  _mapEvents(ShippingInvoiceFormEvent event, Emitter<ShippingInvoiceFormState> emit) async {
    if (event is InitialShippingInvoiceFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitShippingInvoiceFormEvent) {
      await _onSubmitShippingInvoice(event, emit);
    }
    if (event is UpdateShippingInvoiceFormEvent) {
      await _onUpdateShippingInvoice(event, emit);
    }
    if (event is CreateShippingInvoiceFormEvent) {
      await _onCreateShippingInvoice(event, emit);
    }

    if (event is ShippingInvoiceFormChangedEvent) {
      await _onShippingInvoiceFormChanged(event, emit);
    }
    if (event is CancelShippingInvoiceFormEvent) {
      await _onCancelShippingInvoiceFormEvent(event, emit);
    }
    if (event is ClearShippingInvoiceFormEvent) {
      await _onClearShippingInvoiceForm(event, emit);
    }
    if (event is PickAttachmentEvent) {
      await _onPickAttachment(event, emit);
    }

    if (event is ClearAttachmentEvent) {
      await _onClearAttachment(event, emit);
    }
  }

  final formKey = GlobalKey<FormState>();
  final dealIdController = TextEditingController();
  final dealSeriesNumberController = TextEditingController();
  final shippingCompanyNameController = TextEditingController();
  final shippingCostController = TextEditingController();
  final typeMaterialNameController = TextEditingController();
  final shippingDateController = TextEditingController();

  _initial(InitialShippingInvoiceFormEvent event, Emitter<ShippingInvoiceFormState> emit) {
    final attachment = event.shippingInvoice?.attachmentUrl;
    emit(ShippingInvoiceFormLoaded(
      shippingInvoice: event.shippingInvoice,
      updatedMode: event.shippingInvoice != null,
      attachmentUrl: attachment?.isNotEmpty == true ? some(attachment!) : none(),
    ));
    _initializeControllers();
  }

  _initializeControllers() {
    final state = this.state as ShippingInvoiceFormLoaded;
    formKey.currentState?.reset();
    dealIdController.text = state.shippingInvoice?.dealId.toString() ?? '';
    dealSeriesNumberController.text = state.shippingInvoice?.shippingInvoiceNumber ?? '';
    shippingCompanyNameController.text = state.shippingInvoice?.shippingCompanyName ?? '';
    shippingCostController.text = state.shippingInvoice?.shippingCost.toString() ?? '';
    typeMaterialNameController.text = state.shippingInvoice?.typeMaterialName ?? '';
    shippingDateController.text = (state.shippingInvoice?.shippingDate ?? DateTime.now()).formattedDateYYYYMMDD;
    setupControllersListeners();
    add(ShippingInvoiceFormChangedEvent());
  }

  setupControllersListeners() {
    dealIdController.addListener(() => add(ShippingInvoiceFormChangedEvent()));
    dealSeriesNumberController.addListener(() => add(ShippingInvoiceFormChangedEvent()));
    shippingCompanyNameController.addListener(() => add(ShippingInvoiceFormChangedEvent()));
    shippingCostController.addListener(() => add(ShippingInvoiceFormChangedEvent()));
    typeMaterialNameController.addListener(() => add(ShippingInvoiceFormChangedEvent()));
    shippingDateController.addListener(() => add(ShippingInvoiceFormChangedEvent()));
  }

  _onShippingInvoiceFormChanged(ShippingInvoiceFormChangedEvent event, Emitter<ShippingInvoiceFormState> emit) {
    final state = this.state as ShippingInvoiceFormLoaded;
    final formIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      dealSeriesNumberController.text.isNotEmpty,
      shippingCompanyNameController.text.isNotEmpty,
      shippingCostController.text.isNotEmpty,
      shippingDateController.text.isNotEmpty
    ].every((element) => element);

    final isAnyFieldIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      dealSeriesNumberController.text.isNotEmpty,
      shippingCompanyNameController.text.isNotEmpty,
      shippingCostController.text.isNotEmpty,
      typeMaterialNameController.text.isNotEmpty,
      shippingDateController.text != DateTime.now().formattedDateYYYYMMDD,
      state.pickedAttachment.isSome(),
    ].any((element) => element);

    if (state.updatedMode) {
      final shippingInvoice = state.shippingInvoice!;
      final urlChanged = state.attachmentUrl.fold(
        () => shippingInvoice.attachmentUrl.isNotEmpty,
        (a) => a != shippingInvoice.attachmentUrl,
      );
      bool isFormChanged = shippingInvoice.shippingInvoiceNumber != dealSeriesNumberController.text ||
          shippingInvoice.dealId != int.tryParse(dealIdController.text) ||
          shippingInvoice.shippingCompanyName != shippingCompanyNameController.text ||
          shippingInvoice.shippingCost != double.tryParse(shippingCostController.text) ||
          shippingInvoice.typeMaterialName != typeMaterialNameController.text ||
          shippingInvoice.shippingDate.formattedDateYYYYMMDD != shippingDateController.text ||
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

  _onSubmitShippingInvoice(SubmitShippingInvoiceFormEvent event, Emitter<ShippingInvoiceFormState> emit) {
    final state = this.state as ShippingInvoiceFormLoaded;
    if (formKey.currentState?.validate() == false) return;
    if (state.updatedMode) {
      add(UpdateShippingInvoiceFormEvent());
    } else {
      add(CreateShippingInvoiceFormEvent());
    }
  }

  Future _onCreateShippingInvoice(CreateShippingInvoiceFormEvent event, Emitter<ShippingInvoiceFormState> emit) async {
    final state = this.state as ShippingInvoiceFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateShippingInvoiceUseCaseParams(
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      shippingCompanyName: shippingCompanyNameController.text,
      shippingCost: double.tryParse(shippingCostController.text).toDoubleOrZero,
      typeMaterialName: typeMaterialNameController.text,
      shippingDate: DateTime.tryParse(shippingDateController.text).orDefault,
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
    );

    final either = await createShippingInvoiceUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          shippingInvoice: state.shippingInvoice,
        )),
      ),
      (shippingInvoice) {
        emit(state.copyWith(shippingInvoice: shippingInvoice, failureOrSuccessOption: some(right('Shipping Invoice created'))));
      },
    );
  }

  Future _onUpdateShippingInvoice(UpdateShippingInvoiceFormEvent event, Emitter<ShippingInvoiceFormState> emit) async {
    final state = this.state as ShippingInvoiceFormLoaded;

    final deleteAttachment = state.attachmentUrl.isNone() && state.pickedAttachment.isNone();
    final parms = UpdateShippingInvoiceUseCaseParams(
      id: state.shippingInvoice!.id,
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      shippingCompanyName: shippingCompanyNameController.text,
      shippingCost: double.tryParse(shippingCostController.text).toDoubleOrZero,
      typeMaterialName: typeMaterialNameController.text,
      shippingDate: DateTime.tryParse(shippingDateController.text).orDefault,
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
      deleteAttachment: deleteAttachment,
    );

    emit(state.copyWith(loading: true));
    final either = await updateShippingInvoiceUsecase.call(parms);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (shippingInvoice) {
        emit(state.copyWith(shippingInvoice: shippingInvoice, failureOrSuccessOption: some(right('Shipping Invoice updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearShippingInvoiceForm(ClearShippingInvoiceFormEvent event, Emitter<ShippingInvoiceFormState> emit) {
    formKey.currentState?.reset();
    dealIdController.clear();
    dealSeriesNumberController.clear();
    shippingCompanyNameController.clear();
    shippingCostController.clear();
    typeMaterialNameController.clear();
    shippingDateController.text = DateTime.now().formattedDateYYYYMMDD;
    if (state is ShippingInvoiceFormLoaded) {
      final state = this.state as ShippingInvoiceFormLoaded;
      emit(state.copyWith(pickedAttachment: none(), attachmentUrl: none()));
    }
  }

  _onCancelShippingInvoiceFormEvent(ShippingInvoiceFormEvent event, Emitter<ShippingInvoiceFormState> emit) {
    final state = this.state as ShippingInvoiceFormLoaded;
    add(InitialShippingInvoiceFormEvent(shippingInvoice: state.shippingInvoice));
  }

  @override
  Future<void> close() {
    dealIdController.dispose();
    dealSeriesNumberController.dispose();
    shippingCompanyNameController.dispose();
    shippingCostController.dispose();
    typeMaterialNameController.dispose();
    shippingDateController.dispose();
    return super.close();
  }

  _onPickAttachment(PickAttachmentEvent event, Emitter<ShippingInvoiceFormState> emit) async {
    final state = this.state as ShippingInvoiceFormLoaded;
    emit(state.copyWith(pickedAttachment: some(event.file)));
    add(ShippingInvoiceFormChangedEvent());
  }

  _onClearAttachment(ClearAttachmentEvent event, Emitter<ShippingInvoiceFormState> emit) {
    final state = this.state as ShippingInvoiceFormLoaded;
    emit(
      state.copyWith(
        pickedAttachment: none(),
        attachmentUrl: none(),
      ),
    );
    add(ShippingInvoiceFormChangedEvent());
  }
}
