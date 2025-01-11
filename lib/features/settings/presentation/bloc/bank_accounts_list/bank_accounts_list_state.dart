part of 'bank_accounts_list_cubit.dart';

sealed class BankAccountsListState extends Equatable {
  const BankAccountsListState();

  @override
  List<Object> get props => [];
}

final class BankAccountsListInitial extends BankAccountsListState {}

final class BankAccountsListLoaded extends BankAccountsListState {
  final List<BankAccountEntity> bankAccountsList;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool loading;

  const BankAccountsListLoaded({
    required this.bankAccountsList,
    this.failureOrSuccessOption = const None(),
    this.loading = false,
  });

  @override
  List<Object> get props => [bankAccountsList, failureOrSuccessOption, loading];

  BankAccountsListLoaded copyWith({
    List<BankAccountEntity>? bankAccountsList,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loading,
  }) {
    return BankAccountsListLoaded(
      bankAccountsList: bankAccountsList ?? this.bankAccountsList,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      loading: loading ?? this.loading,
    );
  }
}

final class BankAccountsListError extends BankAccountsListState {
  final Failure failure;

  const BankAccountsListError({required this.failure});
}
