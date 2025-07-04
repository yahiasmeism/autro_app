import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:autro_app/features/settings/presentation/widgets/bank_accounts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/overley_loading.dart';
import '../../widgets/add_bank_account_form.dart';

class BankAccountsTab extends StatelessWidget {
  const BankAccountsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankAccountsListCubit, BankAccountsListState>(
      listener: listener,
      builder: (context, state) {
        if (state is BankAccountsListInitial) return const LoadingIndicator();

        if (state is BankAccountsListLoaded) {
          return Stack(
            children: [
              const SingleChildScrollView(
                child: Column(
                  children: [
                    AddBankAccountForm(),
                    SizedBox(height: 48),
                    BankAccountsList(),
                  ],
                ),
              ),
              if (state.loading) const Positioned.fill(child: LoadingOverlay()),
            ],
          );
        } else if (state is BankAccountsListError) {
          return FailureScreen(
            failure: state.failure,
            onRetryTap: () => context.read<BankAccountsListCubit>().onHandleError(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void listener(BuildContext context, BankAccountsListState state) {
    if (state is BankAccountsListLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold((a) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(a)),
            (message) => DialogUtil.showSuccessSnackBar(context, message)),
      );
    }
  }
}
