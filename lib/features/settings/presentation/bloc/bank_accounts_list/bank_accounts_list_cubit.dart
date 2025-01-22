import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/delete_bank_account_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_bank_account_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/bank_account_entity.dart';

part 'bank_accounts_list_state.dart';

@injectable
class BankAccountsListCubit extends Cubit<BankAccountsListState> {
  final GetBankAccountListUseCase getBankAccountListUseCase;
  final AddBankAccountUseCase addBankAccountUseCase;
  final DeleteBankAccountUseCase deleteBankAccountUseCase;
  BankAccountsListCubit(this.getBankAccountListUseCase, this.addBankAccountUseCase, this.deleteBankAccountUseCase)
      : super(BankAccountsListInitial());

  getBankAccountList() async {
    final either = await getBankAccountListUseCase.call(NoParams());
    either.fold(
      (failure) => emit(BankAccountsListError(failure: failure)),
      (bankAccounts) => emit(BankAccountsListLoaded(bankAccountsList: bankAccounts)),
    );
  }

  addNewBankAccount({required AddBankAccountUseCaseParams params}) async {
    final state = this.state as BankAccountsListLoaded;
    if (state.bankAccountsList.length >= 10) {
      const failure = GeneralFailure(message: "You can't add more than 10 bank accounts");
      emit(state.copyWith(failureOrSuccessOption: some(left(failure))));
      return;
    }
    emit(state.copyWith(loading: true));
    final either = await addBankAccountUseCase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (bankAccount) {
        final bankAccounts = [bankAccount, ...state.bankAccountsList];
        emit(
          state.copyWith(
            bankAccountsList: bankAccounts,
            failureOrSuccessOption: some(right('${bankAccount.accountNumber} added successfully')),
          ),
        );
      },
    );
  }

  deleteBankAccount(BankAccountEntity bankAccount) async {
    final state = this.state as BankAccountsListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteBankAccountUseCase.call(bankAccount.id);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (bankAccounts) {
        final bankAccounts = state.bankAccountsList..removeWhere((element) => element.id == bankAccount.id);
        emit(
          state.copyWith(
            bankAccountsList: bankAccounts,
            failureOrSuccessOption: some(right('${bankAccount.accountNumber} deleted successfully')),
          ),
        );
      },
    );
  }

  onHandleError() {
    emit(BankAccountsListInitial());
    getBankAccountList();
  }
}
