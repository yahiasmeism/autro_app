import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/buttons/add_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/inputs/standard_selectable_dropdown.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';
import 'package:flutter/material.dart';

class AddBankAccountForm extends StatefulWidget {
  const AddBankAccountForm({super.key});

  @override
  State<AddBankAccountForm> createState() => _AddBankAccountFormState();
}

class _AddBankAccountFormState extends State<AddBankAccountForm> {
  bool enabledButtons = false;

  @override
  void initState() {
    super.initState();
    setUpListeners();
  }

  setUpListeners() {
    accountNumberController.addListener(updateSavedEnabled);
    bankNameController.addListener(updateSavedEnabled);
    swiftCodeController.addListener(updateSavedEnabled);
    currencyController.addListener(updateSavedEnabled);
  }

  updateSavedEnabled() {
    enabledButtons = accountNumberController.text.isNotEmpty &&
        bankNameController.text.isNotEmpty &&
        swiftCodeController.text.isNotEmpty &&
        currencyController.text.isNotEmpty;

    setState(() {});
  }

  final formKey = GlobalKey<FormState>();
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final swiftCodeController = TextEditingController();
  final currencyController = TextEditingController();

  Future<void> addBankAccount() async {
    if (formKey.currentState?.validate() == true) {
      final params = AddBankAccountUseCaseParams(
        accountNumber: accountNumberController.text,
        bankName: bankNameController.text,
        swiftCode: swiftCodeController.text,
        currency: currencyController.text,
      );
      sl<BankAccountsListCubit>().addNewBankAccount(params: params);
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
                Expanded(
                    child: StandardSelectableDropdownField(
                  items: const [
                    'USD(\$)',
                    'EUR(€)',
                    'GBP(£)',
                    'JPY(¥)',
                    'AUD(A\$)',
                    'CAD(C\$)',
                    'CHF(CHF)',
                    'CNY(¥)',
                    'INR(₹)',
                    'BRL(R\$)',
                    'NGN(₦)',
                    'ZAR(R)',
                    'SAR(﷼)',
                    'AED(د.إ)',
                    'KRW(₩)',
                    'RUB(₽)',
                    'MXN(\$)',
                    'TRY(₺)',
                    'SEK(kr)',
                    'NOK(kr)',
                  ],
                  withValidator: false,
                  controller: currencyController,
                  labelText: 'Currency',
                  hintText: 'Enter currency',
                )),
              ],
            ),
            const SizedBox(height: 32),
            Row(children: [
              const Spacer(),
              ClearAllButton(
                onPressed: enabledButtons
                    ? () {
                        accountNumberController.clear();
                        bankNameController.clear();
                        swiftCodeController.clear();
                        currencyController.clear();
                      }
                    : null,
              ),
              const SizedBox(width: 16),
              AddButton(
                onAddTap: enabledButtons
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
    currencyController.dispose();
    super.dispose();
  }
}
