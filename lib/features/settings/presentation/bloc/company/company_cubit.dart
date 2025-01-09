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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GetCompanyUseCase getCompanyUseCase;
  final ChangeCompanyInfoUseCase changeCompanyInfoUseCase;
  CompanyCubit(this.getCompanyUseCase, this.changeCompanyInfoUseCase) : super(CompanyInitial());

  Future<void> setUpListeners() async {
    if (state is CompanyLoaded) {
      final currentState = state as CompanyLoaded;

      void updateState() {
        final isEdited = currentState.company.name != companyNameController.text ||
            currentState.company.address != companyAddressController.text ||
            currentState.company.phone != companyPhoneController.text ||
            currentState.company.email != companyEmailController.text ||
            currentState.company.telephone != companyTelephoneController.text ||
            currentState.company.website != companyWebsiteController.text;

        emit(currentState.copyWith(saveEnabled: isEdited));
      }

      companyNameController.addListener(updateState);
      companyAddressController.addListener(updateState);
      companyPhoneController.addListener(updateState);
      companyEmailController.addListener(updateState);
      companyTelephoneController.addListener(updateState);
      companyWebsiteController.addListener(updateState);
    }
  }

  initailizedControllers() {
    final state = this.state as CompanyLoaded;
    companyNameController.text = state.company.name;
    companyAddressController.text = state.company.address;
    companyPhoneController.text = state.company.phone;
    companyEmailController.text = state.company.email;
    companyTelephoneController.text = state.company.telephone;
    companyWebsiteController.text = state.company.website;
  }

  Future<void> getCompany() async {
    final either = await getCompanyUseCase.call(NoParams());
    either.fold(
      (failure) => emit(CompanyError(failure)),
      (company) async {
        emit(CompanyLoaded.initial(company));
        await setUpListeners();
        initailizedControllers();
      },
    );
  }

  Future<void> changeCompanyInfo() async {
    final state = this.state as CompanyLoaded;
    final params = ChangeCompanyInfoUseCaseParams(
      name: companyNameController.text,
      address: companyAddressController.text,
      phone: companyPhoneController.text,
      email: companyEmailController.text,
      telephone: companyTelephoneController.text,
      website: companyWebsiteController.text,
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
        ));
      },
    );
    initailizedControllers();
  }

  Future<void> onHandleFailure() async => await getCompany();
}
