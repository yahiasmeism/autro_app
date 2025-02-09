import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/change_company_info_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_company_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'company_state.dart';

@lazySingleton
class CompanyCubit extends Cubit<CompanyState> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
  final TextEditingController companyPhoneController = TextEditingController();
  final TextEditingController companyEmailController = TextEditingController();
  final TextEditingController companyTelephoneController = TextEditingController();
  final TextEditingController companyWebsiteController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GetCompanyUseCase getCompanyUseCase;
  final ChangeCompanyInfoUseCase changeCompanyInfoUseCase;
  CompanyCubit(this.getCompanyUseCase, this.changeCompanyInfoUseCase) : super(CompanyInitial());

  void updateDataChanged() {
    final currentState = state as CompanyLoaded;
    final initailLogo = currentState.company.logoUrl.isNotEmpty ? some(currentState.company.logoUrl) : none();
    final initailSignature = currentState.company.signatureUrl.isNotEmpty ? some(currentState.company.signatureUrl) : none();

    final isEdited = currentState.company.name != companyNameController.text ||
        currentState.company.vat != vatController.text ||
        currentState.company.address != companyAddressController.text ||
        currentState.company.phone != companyPhoneController.text ||
        currentState.company.email != companyEmailController.text ||
        currentState.company.telephone != companyTelephoneController.text ||
        currentState.company.website != companyWebsiteController.text ||
        currentState.pickedLogoFile.isSome() ||
        currentState.pickedSignatureFile.isSome() ||
        currentState.logoUrl != initailLogo ||
        currentState.signatureUrl != initailSignature;

    emit(currentState.copyWith(dataChanged: isEdited));
  }

  Future<void> setUpListeners() async {
    companyNameController.addListener(updateDataChanged);
    companyAddressController.addListener(updateDataChanged);
    companyPhoneController.addListener(updateDataChanged);
    companyEmailController.addListener(updateDataChanged);
    companyTelephoneController.addListener(updateDataChanged);
    companyWebsiteController.addListener(updateDataChanged);
    vatController.addListener(updateDataChanged);
  }

  initailizeControllers() {
    final state = this.state as CompanyLoaded;
    companyNameController.text = state.company.name;
    companyAddressController.text = state.company.address;
    companyPhoneController.text = state.company.phone;
    companyEmailController.text = state.company.email;
    companyTelephoneController.text = state.company.telephone;
    companyWebsiteController.text = state.company.website;
    vatController.text = state.company.vat;

    updateDataChanged();
    setUpListeners();
  }

  cancelChanges() {
    final state = this.state as CompanyLoaded;
    emit(CompanyLoaded.initial(state.company));
  }

  Future<void> getCompany() async {
    emit(CompanyInitial());
    final either = await getCompanyUseCase.call(NoParams());
    either.fold(
      (failure) => emit(CompanyError(failure)),
      (company) async {
        emit(CompanyLoaded.initial(company));
        initailizeControllers();
      },
    );
  }

  Future<void> changeCompanyInfo() async {
    if (!formKey.currentState!.validate()) return;
    final state = this.state as CompanyLoaded;
    final params = ChangeCompanyInfoUseCaseParams(
      name: companyNameController.text,
      vat: vatController.text,
      address: companyAddressController.text,
      phone: companyPhoneController.text,
      email: companyEmailController.text,
      telephone: companyTelephoneController.text,
      website: companyWebsiteController.text,
      logoPath: state.pickedLogoFile.fold(() => null, (file) => file.path),
      signaturePath: state.pickedSignatureFile.fold(() => null, (file) => file.path),
      deleteLogo: state.pickedLogoFile.isNone() && state.logoUrl.isNone(),
      deleteSignature: state.pickedSignatureFile.isNone() && state.signatureUrl.isNone(),
    );
    emit(state.copyWith(loading: true));
    final either = await changeCompanyInfoUseCase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) {
        emit(state.copyWith(failureOrSuccessOption: some(left(failure))));
      },
      (company) {
        emit(state.copyWith(
          company: company,
          failureOrSuccessOption: some(right('Company updated successfully')),
          pickedLogoFile: none(),
          pickedSignatureFile: none(),
          logoUrl: company.logoUrl.isNotEmpty ? some(company.logoUrl) : none(),
          signatureUrl: company.signatureUrl.isNotEmpty ? some(company.signatureUrl) : none(),
        ));
        initailizeControllers();
      },
    );
  }

  Future<void> onHandleFailure() async {
    emit(CompanyInitial());
    await getCompany();
  }

  pickLogoFile(File file) {
    final state = this.state as CompanyLoaded;
    emit(state.copyWith(pickedLogoFile: some(file)));
    updateDataChanged();
  }

  pickSignatureFile(File file) {
    final state = this.state as CompanyLoaded;
    emit(state.copyWith(pickedSignatureFile: some(file)));
    updateDataChanged();
  }

  clearLogoFile() {
    final state = this.state as CompanyLoaded;
    emit(state.copyWith(pickedLogoFile: none(), logoUrl: none()));
    updateDataChanged();
  }

  clearSignatureFile() {
    final state = this.state as CompanyLoaded;
    emit(state.copyWith(pickedSignatureFile: none(), signatureUrl: none()));
    updateDataChanged();
  }

  @override
  Future<void> close() {
    companyNameController.dispose();
    companyAddressController.dispose();
    companyPhoneController.dispose();
    companyEmailController.dispose();
    companyTelephoneController.dispose();
    companyWebsiteController.dispose();
    vatController.dispose();
    return super.close();
  }
}
