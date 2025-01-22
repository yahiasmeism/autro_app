import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_card.dart';
import '../../../../settings/presentation/widgets/bank_accounts_list_selection_field.dart';
import '../../bloc/cubit/proforma_form_cubit.dart';

class ProformaFormBankDetails extends StatelessWidget {
  const ProformaFormBankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProformaFormCubit>();

    return StandardCard(
      title: 'Bank Details',
      child: BankAccountsListSelectionField(
        nameController: cubit.bankNameController,
        idController: cubit.bankIdController,
      ),
    );
  }
}
