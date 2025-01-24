import 'package:autro_app/features/proformas/presentation/widgets/proformas_list_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_card.dart';
import '../../bloc/invoice_form/invoice_form_cubit.dart';

class InvoiceFormProformaDetails extends StatelessWidget {
  const InvoiceFormProformaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvoiceFormCubit>();

    return StandardCard(
      title: 'Proforma Details',
      child: Row(
        children: [
          Expanded(
            child: ProformasListSelectionField(
              nameController: bloc.proformaNameController,
              idController: bloc.proformaIdController,
              onItemTap: (proforma) {
                bloc.customerIdController.text = proforma.customer.id.toString();
                bloc.customerNameController.text = proforma.customer.name;
                bloc.taxIdController.text = proforma.taxId;
                bloc.bankIdController.text = proforma.bankAccount.id.toString();
                bloc.bankNameController.text = proforma.bankAccount.formattedLabel;
                bloc.notesController.text = proforma.notes;
                bloc.invoiceNumberController.text = proforma.proformaNumber;
              },
            ),
          ),
        ],
      ),
    );
  }
}
