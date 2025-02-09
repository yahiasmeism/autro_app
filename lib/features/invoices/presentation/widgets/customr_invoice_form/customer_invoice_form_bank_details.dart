import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_card.dart';
import '../../../../settings/presentation/widgets/bank_accounts_list_selection_field.dart';
import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';

class CustomerInvoiceFormBankDetails extends StatelessWidget {
  const CustomerInvoiceFormBankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerInvoiceFormCubit>();

    return StandardCard(
      title: 'Bank Details',
      child: BankAccountsListSelectionField(
        canOpenDialog: false,
        nameController: cubit.bankLableController,
        idController: cubit.bankIdController,
        onItemTapped: (p0) {
          cubit.bankLableController.text = p0.formattedLabel;
          cubit.bankIdController.text = p0.id.toString();
          cubit.bankAccountNumberController.text = p0.accountNumber;
          cubit.swiftCodeController.text = p0.swiftCode;
          cubit.bankNameController.text = p0.bankName;
        },
      ),
    );
  }
}
