part of 'bank_accounts_list_cubit.dart';

sealed class BankAccountsListState extends Equatable {
  const BankAccountsListState();

  @override
  List<Object> get props => [];
}

final class BankAccountsListInitial extends BankAccountsListState {}

final class BankAccountsListLoaded extends BankAccountsListState {
  final List<BankAccountEntity> bankAccountsList;
  final Option<Failure> failureOption;
  final bool loading;

  const BankAccountsListLoaded({
    required this.bankAccountsList,
    this.failureOption = const None(),
    this.loading = false,
  });

  @override
  List<Object> get props => [bankAccountsList, failureOption, loading];

  BankAccountsListLoaded copyWith({
    List<BankAccountEntity>? bankAccountsList,
    Option<Failure>? failureOption,
    bool? loading,
  }) {
    return BankAccountsListLoaded(
      bankAccountsList: bankAccountsList ?? this.bankAccountsList,
      failureOption: failureOption ?? this.failureOption,
      loading: loading ?? this.loading,
    );
  }
}

final class BankAccountsListError extends BankAccountsListState {
  final Failure failure;

  const BankAccountsListError({required this.failure});
}
