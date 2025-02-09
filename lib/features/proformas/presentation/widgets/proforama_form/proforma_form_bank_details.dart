import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_card.dart';
import '../../../../settings/presentation/widgets/bank_accounts_list_selection_field.dart';
import '../../bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';

class ProformaFormBankDetails extends StatelessWidget {
  const ProformaFormBankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerProformaFormCubit>();

    return StandardCard(
      title: 'Bank Details',
      child: BankAccountsListSelectionField(
        nameController: cubit.bankLabelController,
        idController: cubit.bankIdController,
        onItemTapped: (p0) {
          cubit.bankNameController.text = p0.bankName;
          cubit.bankAccountNumberController.text = p0.accountNumber;
          cubit.swiftCodeController.text = p0.swiftCode;
        },
      ),
    );
  }
}
