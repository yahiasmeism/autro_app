import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_card.dart';
import '../../../../settings/presentation/widgets/bank_accounts_list_selection_field.dart';
import '../../bloc/invoice_form/invoice_form_cubit.dart';

class InvoiceFormBankDetails extends StatelessWidget {
  const InvoiceFormBankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InvoiceFormCubit>();

    return StandardCard(
      title: 'Bank Details',
      child: BankAccountsListSelectionField(
        canOpenDialog: false,
        nameController: cubit.bankNameController,
        idController: cubit.bankIdController,
      ),
    );
  }
}
