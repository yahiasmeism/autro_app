import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_overlay.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:autro_app/features/settings/presentation/widgets/bank_accounts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/add_bank_account_form.dart';

class BankAccountsTab extends StatelessWidget {
  const BankAccountsTab({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BankAccountsListCubit>().getBankAccountList();
    return BlocBuilder<BankAccountsListCubit, BankAccountsListState>(
      builder: (context, state) {
        if (state is BankAccountsListInitial) return const Center(child: CircularProgressIndicator());

        if (state is BankAccountsListLoaded) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                const Column(
                  children: [
                    AddBankAccountForm(),
                    SizedBox(height: 48),
                    BankAccountsList(),
                  ],
                ),
                if (state.loading) const Positioned.fill(child: LoadingOverlay()),
              ],
            ),
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
}
