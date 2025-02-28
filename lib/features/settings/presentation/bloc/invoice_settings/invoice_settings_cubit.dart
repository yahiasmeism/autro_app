import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/invoice_settings_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_invoice_settings_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/use_cases/set_invoice_settings_use_case.dart';

part 'invoice_settings_state.dart';

@lazySingleton
class InvoiceSettingsCubit extends Cubit<InvoiceSettingsState> {
  final GetInvoiceSettingsUseCase getInvoiceSettingsUseCase;
  final SetInvoiceSettingsUseCase setInvoiceSettingsUseCase;
  InvoiceSettingsCubit(this.getInvoiceSettingsUseCase, this.setInvoiceSettingsUseCase) : super(InvoiceSettingsInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController modificationsOnBLController = TextEditingController();
  final TextEditingController exemptController = TextEditingController();
  final TextEditingController shippingInstructionsController = TextEditingController();
  final TextEditingController typeOfTransportController = TextEditingController();
  final TextEditingController loadingPicturesController = TextEditingController();
  final TextEditingController loadingDateController = TextEditingController();
  final TextEditingController specialConditionsController = TextEditingController();

  void updateDataChanged() {
    final currentState = state as InvoiceSettingsLoaded;
    final isEdited = currentState.invoiceSettings.modificationOnBl != modificationsOnBLController.text ||
        currentState.invoiceSettings.exempt != exemptController.text ||
        currentState.invoiceSettings.shippingInstructions != shippingInstructionsController.text ||
        currentState.invoiceSettings.typeOfTransport != typeOfTransportController.text ||
        currentState.invoiceSettings.loadingPictures != loadingPicturesController.text ||
        currentState.invoiceSettings.loadingDate != loadingDateController.text || 
        currentState.invoiceSettings.specialConditions != specialConditionsController.text;

    emit(currentState.copyWith(dataChanged: isEdited));
  }

  Future<void> setUpListeners() async {
    modificationsOnBLController.addListener(() => updateDataChanged());
    exemptController.addListener(() => updateDataChanged());
    shippingInstructionsController.addListener(() => updateDataChanged());
    typeOfTransportController.addListener(() => updateDataChanged());
    loadingPicturesController.addListener(() => updateDataChanged());
    loadingDateController.addListener(() => updateDataChanged());
    specialConditionsController.addListener(() => updateDataChanged());
  }

  initailizeControllers() {
    final state = this.state as InvoiceSettingsLoaded;
    modificationsOnBLController.text = state.invoiceSettings.modificationOnBl;
    exemptController.text = state.invoiceSettings.exempt;
    shippingInstructionsController.text = state.invoiceSettings.shippingInstructions;
    typeOfTransportController.text = state.invoiceSettings.typeOfTransport;
    loadingPicturesController.text = state.invoiceSettings.loadingPictures;
    loadingDateController.text = state.invoiceSettings.loadingDate;
    specialConditionsController.text = state.invoiceSettings.specialConditions;

    setUpListeners();
  }

  getInvoiceSettings() async {
    Either<Failure, InvoiceSettingsEntity> result = await getInvoiceSettingsUseCase(NoParams());
    result.fold((failure) => emit(InvoiceSettingsError(failure: failure)), (invoiceSettings) {
      emit(InvoiceSettingsLoaded.initial(invoiceSettings));
      initailizeControllers();
    });
  }

  Future<void> setInvoiceSettings() async {
    if (!formKey.currentState!.validate()) return;
    final state = this.state as InvoiceSettingsLoaded;

    final newSettings = InvoiceSettingsEntity(
      modificationOnBl: modificationsOnBLController.text ,
      exempt: exemptController.text,
      shippingInstructions: shippingInstructionsController.text,
      typeOfTransport: typeOfTransportController.text,
      loadingPictures: loadingPicturesController.text,
      loadingDate: loadingDateController.text,
      specialConditions: specialConditionsController.text,
    );

    emit(state.copyWith(loading: true));
    final either = await setInvoiceSettingsUseCase.call(newSettings);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) {
        emit(state.copyWith(failureOrSuccessOption: some(left(failure))));
      },
      (invoiceSettings) {
        emit(state.copyWith(
          invoiceSettings: invoiceSettings,
          failureOrSuccessOption: some(right('Invoice settings updated successfully')),
        ));
        initailizeControllers();
      },
    );
  }

  onHandleError() async {
    emit(InvoiceSettingsInitial());
    await Future.delayed(const Duration(seconds: 1));
    getInvoiceSettings();
  }

  cancelChanges() => initailizeControllers();
}
