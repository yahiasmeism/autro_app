import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankAccountsList extends StatelessWidget {
  const BankAccountsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BankAccountsListCubit, BankAccountsListState>(
      builder: (context, state) {
        if (state is BankAccountsListLoaded) {
          return Column(
            children: [
              const StandartListTitle(title: 'Registered Accounts'),
              _buildHeaderRow(),
              _buildList(context, state),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'Bank Name ',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Text(
              'Account Number',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Text(
              'SWIFT Code',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Text(
              'Currency',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              textAlign: TextAlign.center,
              'Actions',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTileRow(BankAccountEntity bankAccount, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                bankAccount.bankName,
                style: TextStyles.font16Regular,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 3,
              child: Text(
                bankAccount.accountNumber,
                style: TextStyles.font16Regular,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 3,
              child: Text(
                bankAccount.swiftCode,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 3,
              child: Text(
                bankAccount.currency,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(onPressed: () {}),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context.read<BankAccountsListCubit>().deleteBankAccount(bankAccount);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, BankAccountsListLoaded state) {
    if (state.bankAccountsList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Center(child: Text('No Bank Accounts', style: TextStyles.font16Regular)),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: state.bankAccountsList.length,
      itemBuilder: (context, index) {
        return _buildTileRow(state.bankAccountsList[index], context);
      },
    );
  }
}
