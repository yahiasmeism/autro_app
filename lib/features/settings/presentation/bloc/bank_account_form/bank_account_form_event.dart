part of 'bank_account_form_bloc.dart';

sealed class BankAccountFormEvent extends Equatable {
  const BankAccountFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialBankAccountFormEvent extends BankAccountFormEvent {
  final int? bankAccountId;
  const InitialBankAccountFormEvent({this.bankAccountId});

  @override
  List<Object?> get props => [bankAccountId];
}

final class SubmitBankAccountFormEvent extends BankAccountFormEvent {}

final class UpdateBankAccountFormEvent extends BankAccountFormEvent {}

class CreateBankAccountFormEvent extends BankAccountFormEvent {}

class BankAccountFormChangedEvent extends BankAccountFormEvent {}

class ClearBankAccountFormEvent extends BankAccountFormEvent {}

class CancelBankAccountFormEvent extends BankAccountFormEvent {}

class BankAccountFormHandleError extends BankAccountFormEvent {}
