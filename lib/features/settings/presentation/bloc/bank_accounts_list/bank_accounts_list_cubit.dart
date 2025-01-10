import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_bank_account_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/bank_account_entity.dart';

part 'bank_accounts_list_state.dart';

@lazySingleton
class BankAccountsListCubit extends Cubit<BankAccountsListState> {
  final GetBankAccountListUseCase getBankAccountListUseCase;
  final AddBankAccountUseCase addBankAccountUseCase;
  BankAccountsListCubit(this.getBankAccountListUseCase, this.addBankAccountUseCase) : super(BankAccountsListInitial());

  getBankAccountList() async {
    final either = await getBankAccountListUseCase.call(NoParams());
    either.fold(
      (failure) => emit(BankAccountsListError(failure: failure)),
      (bankAccounts) => emit(BankAccountsListLoaded(bankAccountsList: bankAccounts)),
    );
  }

  addNewBankAccount({required AddBankAccountUseCaseParams params}) async {
    final state = this.state as BankAccountsListLoaded;
    emit(state.copyWith(loading: true));
    final either = await addBankAccountUseCase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOption: some(failure))),
      (bankAccount) {
        final bankAccounts = state.bankAccountsList..add(bankAccount);
        emit(state.copyWith(bankAccountsList: bankAccounts));
      },
    );
  }

  onHandleError() {
    emit(BankAccountsListInitial());
    getBankAccountList();
  }
}
