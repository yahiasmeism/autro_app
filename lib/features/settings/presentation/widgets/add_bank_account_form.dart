import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/buttons/add_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBankAccountForm extends StatefulWidget {
  const AddBankAccountForm({super.key});

  @override
  State<AddBankAccountForm> createState() => _AddBankAccountFormState();
}

class _AddBankAccountFormState extends State<AddBankAccountForm> {
  bool addBankAccountEnabled = false;
  bool clearAllEnabled = false;
  @override
  void initState() {
    super.initState();
    setUpListeners();
  }

  setUpListeners() {
    accountNumberController.addListener(updateOnChanged);
    bankNameController.addListener(updateOnChanged);
    swiftCodeController.addListener(updateOnChanged);
  }

  updateOnChanged() {
    updateSavedEnabled();
    updateClearAllEnabled();
  }

  updateSavedEnabled() {
    bool isChanged =
        accountNumberController.text.isNotEmpty && bankNameController.text.isNotEmpty && swiftCodeController.text.isNotEmpty;

    if (isChanged != addBankAccountEnabled) {
      addBankAccountEnabled = isChanged;
      setState(() {});
    }
  }

  updateClearAllEnabled() {
    bool isChanged =
        accountNumberController.text.isNotEmpty || bankNameController.text.isNotEmpty || swiftCodeController.text.isNotEmpty;

    if (isChanged != clearAllEnabled) {
      clearAllEnabled = isChanged;
      setState(() {});
    }
  }

  final formKey = GlobalKey<FormState>();
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final swiftCodeController = TextEditingController();

  Future<void> addBankAccount() async {
    if (formKey.currentState?.validate() == true) {
      final params = AddBankAccountUseCaseParams(
        accountNumber: accountNumberController.text,
        bankName: bankNameController.text,
        swiftCode: swiftCodeController.text,
      );
      context.read<BankAccountsListCubit>().addNewBankAccount(params: params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: StandardCard(
        title: 'Add New Bank Account',
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: StandardInput(
                  validator: (p0) => ValidatorUtils.validateRequiredField(p0, 'Account Number'),
                  controller: accountNumberController,
                  labelText: 'Account Number',
                  hintText: 'Enter account number',
                )),
                const SizedBox(width: 32),
                Expanded(
                    child: StandardInput(
                  validator: (p0) => ValidatorUtils.validateRequiredField(p0, 'Bank Name'),
                  controller: bankNameController,
                  labelText: 'Bank Name',
                  hintText: 'Enter bank name',
                )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: StandardInput(
                  validator: (p0) => ValidatorUtils.validateRequiredField(p0, 'SWIFT Code'),
                  controller: swiftCodeController,
                  labelText: 'SWIFT Code',
                  hintText: 'Enter SWIFT code',
                )),
                const SizedBox(width: 32),
                const Expanded(
                    child: StandardInput(
                  readOnly: true,
                  initialValue: 'EUR(€)',
                  labelText: 'Currency',
                )),
              ],
            ),
            const SizedBox(height: 32),
            Row(children: [
              const Spacer(),
              ClearAllButton(
                onPressed: clearAllEnabled
                    ? () {
                        accountNumberController.clear();
                        bankNameController.clear();
                        swiftCodeController.clear();
                        setState(() {});
                      }
                    : null,
              ),
              const SizedBox(width: 16),
              AddButton(
                onAddTap: addBankAccountEnabled
                    ? () {
                        addBankAccount();
                      }
                    : null,
                labelAddButton: 'Add Account',
              ),
            ])
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    bankNameController.dispose();
    swiftCodeController.dispose();
    super.dispose();
  }
}
