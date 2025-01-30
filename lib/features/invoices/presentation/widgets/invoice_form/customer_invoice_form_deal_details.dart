import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/features/deals/presentation/widgets/deals_list_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_card.dart';
import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';

class CustomerInvoiceFormProformaDetails extends StatelessWidget {
  const CustomerInvoiceFormProformaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerInvoiceFormCubit>();

    return StandardCard(
      title: 'Deal Details',
      child: Row(
        children: [
          Expanded(
            child: DealsListSelectionField(
              seriesNumberController: bloc.dealSeriesNumberController,
              idController: bloc.dealIdController,
              onItemTap: (deal) {
                final proforma = deal.customerProforma;
                if (proforma == null) {
                  DialogUtil.showErrorSnackBar(context, 'Deal has no proforma,please add one');
                  return;
                }
                bloc.customerIdController.text = proforma.customer.id.toString();
                bloc.customerNameController.text = proforma.customer.name;
                bloc.taxIdController.text = proforma.taxId;
                bloc.bankIdController.text = proforma.bankAccount.id.toString();
                bloc.bankNameController.text = proforma.bankAccount.formattedLabel;
                bloc.notesController.text = proforma.notes;
                bloc.invoiceNumberController.text = proforma.proformaNumber;
                bloc.dealIdController.text = deal.id.toString();
                bloc.dealSeriesNumberController.text = deal.formattedSeriesNumber;
              },
            ),
          ),
        ],
      ),
    );
  }
}
