import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_bank_account_by_id_use_case.dart';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/bank_account_entity.dart';
import '../../../domin/use_cases/add_bank_account_use_case.dart';
import '../../../domin/use_cases/update_bank_account_use_case.dart';

part 'bank_account_form_event.dart';
part 'bank_account_form_state.dart';

@injectable
class BankAccountFormBloc extends Bloc<BankAccountFormEvent, BankAccountFormState> {
  final AddBankAccountUseCase addBankAccountUsecase;
  final GetBankAccountByIdUseCase getBankAccountUseCase;
  final UpdateBankAccountUseCase updateBankAccountUsecase;
  BankAccountFormBloc(
    this.addBankAccountUsecase,
    this.getBankAccountUseCase,
    this.updateBankAccountUsecase,
  ) : super(BankAccountFormInitial()) {
    on<BankAccountFormEvent>(_mapEvents);
  }

  _mapEvents(BankAccountFormEvent event, Emitter<BankAccountFormState> emit) async {
    if (event is InitialBankAccountFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitBankAccountFormEvent) {
      await _onSubmitBankAccount(event, emit);
    }
    if (event is UpdateBankAccountFormEvent) {
      await _onUpdateBankAccount(event, emit);
    }
    if (event is CreateBankAccountFormEvent) {
      await _onCreateBankAccount(event, emit);
    }
    if (event is BankAccountFormChangedEvent) {
      await _onBankAccountFormChanged(event, emit);
    }
    if (event is CancelBankAccountFormEvent) {
      await _onCancelBankAccountFormEvent(event, emit);
    }
    if (event is ClearBankAccountFormEvent) {
      await _onClearBankAccountForm(event, emit);
    }
    if (event is BankAccountFormHandleError) {
      await _onHandleError(event, emit);
    }
  }

  final bankAccountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final swiftCodeController = TextEditingController();
  final currencyController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  _initial(InitialBankAccountFormEvent event, Emitter<BankAccountFormState> emit) async {
    if (event.bankAccountId != null) {
      final either = await getBankAccountUseCase.call(event.bankAccountId!);
      either.fold(
        (failure) {
          emit(BankAccountFormError(failure: failure, id: event.bankAccountId!));
        },
        (bankAccount) {
          emit(BankAccountFormLoaded(
            bankAccount: bankAccount,
            updatedMode: true,
          ));
        },
      );
    } else {
      emit(const BankAccountFormLoaded());
    }

    _initializeControllers();
  }

  _initializeControllers() {
    if (state is BankAccountFormLoaded) {
      final state = this.state as BankAccountFormLoaded;
      formKey.currentState?.reset();
      bankAccountNumberController.text = state.bankAccount?.accountNumber ?? '';
      bankNameController.text = state.bankAccount?.bankName ?? '';
      swiftCodeController.text = state.bankAccount?.swiftCode ?? '';
      currencyController.text = state.bankAccount?.currency ?? '';

      setupControllersListeners();
      add(BankAccountFormChangedEvent());
    }
  }

  setupControllersListeners() {
    for (var controller in [
      bankAccountNumberController,
      bankNameController,
      swiftCodeController,
      currencyController,
    ]) {
      controller.addListener(() => add(BankAccountFormChangedEvent()));
    }
  }

  _onBankAccountFormChanged(BankAccountFormChangedEvent event, Emitter<BankAccountFormState> emit) {
    final state = this.state as BankAccountFormLoaded;
    final formIsNotEmpty = bankAccountNumberController.text.isNotEmpty &&
        bankNameController.text.isNotEmpty &&
        swiftCodeController.text.isNotEmpty &&
        currencyController.text.isNotEmpty;

    if (state.updatedMode) {
      final bankAccount = state.bankAccount!;

      bool isFormChanged = bankAccount.accountNumber != bankAccountNumberController.text ||
          bankAccount.bankName != bankNameController.text ||
          bankAccount.swiftCode != swiftCodeController.text ||
          bankAccount.currency != currencyController.text;
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

  _onSubmitBankAccount(SubmitBankAccountFormEvent event, Emitter<BankAccountFormState> emit) {
    final state = this.state as BankAccountFormLoaded;
    if (formKey.currentState?.validate() == false) return;

    if (state.updatedMode) {
      add(UpdateBankAccountFormEvent());
    } else {
      add(CreateBankAccountFormEvent());
    }
  }

  Future _onCreateBankAccount(CreateBankAccountFormEvent event, Emitter<BankAccountFormState> emit) async {
    final state = this.state as BankAccountFormLoaded;
    emit(state.copyWith(loading: true));

    final params = AddBankAccountUseCaseParams(
      accountNumber: bankAccountNumberController.text,
      bankName: bankNameController.text,
      swiftCode: swiftCodeController.text,
      currency: currencyController.text,
    );

    final either = await addBankAccountUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          bankAccount: state.bankAccount,
        )),
      ),
      (bankAccount) {
        emit(state.copyWith(bankAccount: bankAccount, failureOrSuccessOption: some(right('BankAccount created'))));
      },
    );
  }

  Future _onUpdateBankAccount(UpdateBankAccountFormEvent event, Emitter<BankAccountFormState> emit) async {
    final state = this.state as BankAccountFormLoaded;

    emit(state.copyWith(loading: true));
    final params = UpdateBankAccountUseCaseParams(
      id: state.bankAccount!.id,
      accountNumber: bankAccountNumberController.text,
      bankName: bankNameController.text,
      swiftCode: swiftCodeController.text,
      currency: currencyController.text,
    );
    final either = await updateBankAccountUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (bankAccount) {
        emit(state.copyWith(bankAccount: bankAccount, failureOrSuccessOption: some(right('BankAccount updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearBankAccountForm(ClearBankAccountFormEvent event, Emitter<BankAccountFormState> emit) {
    formKey.currentState?.reset();
    for (var element in [
      bankAccountNumberController,
      bankNameController,
      swiftCodeController,
      currencyController,
    ]) {
      element.clear();
    }
  }

  _onCancelBankAccountFormEvent(BankAccountFormEvent event, Emitter<BankAccountFormState> emit) {
    _initializeControllers();
  }

  @override
  Future<void> close() {
    bankAccountNumberController.dispose();
    bankNameController.dispose();
    swiftCodeController.dispose();
    currencyController.dispose();
    return super.close();
  }

  _onHandleError(BankAccountFormHandleError event, Emitter<BankAccountFormState> emit) async {
    if (state is BankAccountFormError) {
      final state = this.state as BankAccountFormError;
      emit(BankAccountFormInitial());
      await Future.delayed(const Duration(milliseconds: 300));
      add(InitialBankAccountFormEvent(bankAccountId: state.id));
    }
  }
}
