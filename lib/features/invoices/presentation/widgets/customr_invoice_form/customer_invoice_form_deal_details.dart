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

    return BlocBuilder<CustomerInvoiceFormCubit, CustomerInvoiceFormState>(
      builder: (context, state) {
        return StandardCard(
          title: 'Deal Details',
          child: Row(
            children: [
              Expanded(
                child: DealsListSelectionField(
                  enabled: state is CustomerInvoiceFormLoaded && !state.updatedMode,
                  seriesNumberController: bloc.dealSeriesNumberController,
                  idController: bloc.dealIdController,
                  onItemTap: (deal) {
                    if (deal.customerInvoice != null) {
                      DialogUtil.showErrorDialog(context,
                          content: 'This deal connected with another invoice , please select another deal');
                      return;
                    }
                    final proforma = deal.customerProforma;
                    if (proforma == null) {
                      DialogUtil.showErrorSnackBar(context, 'Deal has no proforma,please add one');
                      return;
                    }
                    bloc.customerIdController.text = deal.customer?.id.toString() ?? '';
                    bloc.customerNameController.text = deal.customer?.name ?? '';
                    bloc.taxIdController.text = proforma.taxId;
                    bloc.bankIdController.text = deal.bankAccount?.id.toString() ?? '';
                    bloc.bankLableController.text = deal.bankAccount?.formattedLabel ?? '';
                    bloc.notesController.text = proforma.notes;
                    bloc.invoiceNumberController.text = deal.dealNumber;
                    bloc.dealIdController.text = deal.id.toString();
                    bloc.dealSeriesNumberController.text = deal.dealNumber;

                    bloc.customerAddressController.text = deal.customer?.formattedAddress ?? '';
                    bloc.bankLableController.text = deal.bankAccount?.formattedLabel ?? '';
                    bloc.bankIdController.text = deal.bankAccount?.id.toString() ?? '';
                    bloc.bankAccountNumberController.text = deal.bankAccount?.accountNumber ?? '';
                    bloc.swiftCodeController.text = deal.bankAccount?.swiftCode ?? '';
                    bloc.bankNameController.text = deal.bankAccount?.bankName ?? '';
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
