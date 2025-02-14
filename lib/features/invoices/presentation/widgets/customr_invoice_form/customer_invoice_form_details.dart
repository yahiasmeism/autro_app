import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/core/widgets/standard_selection_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/dialog_utils.dart';
import '../../../../deals/presentation/widgets/deals_list_selection_field.dart';
import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';

class CustomerInvoiceFormDetails extends StatelessWidget {
  const CustomerInvoiceFormDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerInvoiceFormCubit>();
    return StandardCard(
      title: 'Invoice Details',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildConnectedDealField(context)),
          const SizedBox(width: 32),
          Expanded(
            child: StandardInput(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  bloc.invoiceDateController.text = selectedDate.formattedDateYYYYMMDD;
                }
              },
              readOnly: true,
              iconSuffix: const Icon(Icons.calendar_month),
              hintText: 'e.g yyyy-mm-dd',
              controller: bloc.invoiceDateController,
              labelText: 'Invoice Date',
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: StandardSelectableDropdown(
              onChanged: (p0) {
                bloc.statusController.text = p0 ?? '';
              },
              items: const ['Pending', 'Sent'],
              hintText: 'e.g yyyy-mm-dd',
              initialValue: bloc.statusController.text.isEmpty ? 'Pending' : bloc.statusController.text,
              labelText: 'Status',
            ),
          ),
        ],
      ),
    );
  }

  _buildConnectedDealField(BuildContext context) {
    final bloc = context.read<CustomerInvoiceFormCubit>();
    return Expanded(
      child: BlocBuilder<CustomerInvoiceFormCubit, CustomerInvoiceFormState>(
        builder: (context, state) {
          return DealsListSelectionField(
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
              bloc.currencyController.text = deal.bankAccount?.currency ?? '';
            },
          );
        },
      ),
    );
  }
}
