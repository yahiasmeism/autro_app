import 'package:autro_app/core/widgets/buttons/add_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';

class AddBankAccountForm extends StatelessWidget {
  const AddBankAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: StandardCard(
        title: 'Add New Bank Account',
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                    child: StandardInput(
                  labelText: 'Account Number',
                  hintText: 'Enter account number',
                )),
                SizedBox(width: 32),
                Expanded(
                    child: StandardInput(
                  labelText: 'Bank Name',
                  hintText: 'Enter bank name',
                )),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                    child: StandardInput(
                  labelText: 'SWIFT Code',
                  hintText: 'Enter SWIFT code',
                )),
                SizedBox(width: 32),
                Expanded(
                    child: StandardInput(
                  labelText: 'Currency',
                  hintText: 'Enter currency',
                )),
              ],
            ),
            const SizedBox(height: 32),
            Row(children: [
              const Spacer(),
              ClearAllButton(
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              AddButton(
                onAddTap: () {},
                labelAddButton: 'Add Account',
              ),
            ])
          ],
        ),
      ),
    );
  }
}
