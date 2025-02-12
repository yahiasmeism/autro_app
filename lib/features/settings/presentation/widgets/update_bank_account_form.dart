import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/buttons/cancel_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/core/widgets/standard_selection_dropdown.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_indecator.dart';
import '../../../../core/widgets/overley_loading.dart';
import '../bloc/bank_account_form/bank_account_form_bloc.dart';

class UpdateBankAccountFormScreen extends StatelessWidget {
  const UpdateBankAccountFormScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    final bloc = sl<BankAccountFormBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bank Account'),
      ),
      body: BlocProvider.value(
        value: bloc..add(InitialBankAccountFormEvent(bankAccountId: id)),
        child: BlocConsumer<BankAccountFormBloc, BankAccountFormState>(
          bloc: bloc,
          listener: listener,
          builder: (context, state) {
            if (state is BankAccountFormInitial) {
              return const LoadingIndicator();
            } else if (state is BankAccountFormLoaded) {
              return Stack(
                children: [
                  _buildLoadedState(bloc, context, state),
                  if (state.loading) const Positioned.fill(child: LoadingOverlay()),
                ],
              );
            } else if (state is BankAccountFormError) {
              return FailureScreen(
                failure: state.failure,
                onRetryTap: () => context.read<BankAccountFormBloc>().add(BankAccountFormHandleError()),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Column _buildLoadedState(BankAccountFormBloc bloc, BuildContext context, BankAccountFormLoaded state) {
    return Column(
      children: [
        StandardCard(
          title: 'Bank Account Information',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StandardInput(
                      showRequiredIndecator: true,
                      hintText: 'Enter account number',
                      labelText: 'Account Number',
                      controller: bloc.bankAccountNumberController,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: StandardInput(
                      showRequiredIndecator: true,
                      hintText: 'Enter bank name',
                      labelText: 'Bank Name',
                      controller: bloc.bankNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: StandardInput(
                      showRequiredIndecator: true,
                      hintText: 'Enter swift code',
                      labelText: 'Swift Code',
                      controller: bloc.swiftCodeController,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: StandardSelectableDropdown(
                      onChanged: (p0) {
                        bloc.currencyController.text = p0 ?? '';
                      },
                      items: const ['EUR', 'USD'],
                      hintText: 'Select currency',
                      labelText: 'Currency',
                      initialValue: bloc.currencyController.text.isNotEmpty ? bloc.currencyController.text : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildButtons(context, state),
            ],
          ),
        ),
      ],
    );
  }

  _buildButtons(BuildContext context, BankAccountFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(
              onPressed: () => context.read<BankAccountFormBloc>().add(CancelBankAccountFormEvent()),
            ),
          SizedBox(width: state.cancelEnabled ? 16 : 0),
          ClearAllButton(
            onPressed: state.clearEnabled ? () => context.read<BankAccountFormBloc>().add(ClearBankAccountFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed: state.saveEnabled ? () => context.read<BankAccountFormBloc>().add(SubmitBankAccountFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, BankAccountFormState state) {
    if (state is BankAccountFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.bankAccount != null) {
              context.read<BankAccountsListCubit>().refrshList();
            }
            NavUtil.pop(context, state.bankAccount);
            return DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
