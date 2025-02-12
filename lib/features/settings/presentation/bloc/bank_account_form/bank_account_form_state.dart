part of 'bank_account_form_bloc.dart';

sealed class BankAccountFormState extends Equatable {
  const BankAccountFormState();

  @override
  List<Object?> get props => [];
}

final class BankAccountFormInitial extends BankAccountFormState {}

final class BankAccountFormLoaded extends BankAccountFormState {
  final BankAccountEntity? bankAccount;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;

  const BankAccountFormLoaded(
      {this.bankAccount,
      this.loading = false,
      this.failureOrSuccessOption = const None(),
      this.updatedMode = false,
      this.saveEnabled = false,
      this.cancelEnabled = false,
      this.clearEnabled = false});
  @override
  List<Object?> get props => [
        bankAccount,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
      ];

  BankAccountFormLoaded copyWith({
    BankAccountEntity? bankAccount,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return BankAccountFormLoaded(
      updatedMode: updatedMode ?? this.updatedMode,
      bankAccount: bankAccount ?? this.bankAccount,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
    );
  }
}

class BankAccountFormError extends BankAccountFormState {
  final Failure failure;
  final int id;

  const BankAccountFormError({required this.failure, required this.id});

  @override
  List<Object?> get props => [failure, id];
}
