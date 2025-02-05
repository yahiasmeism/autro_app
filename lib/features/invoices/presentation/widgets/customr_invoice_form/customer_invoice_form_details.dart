import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          Expanded(
            child: StandardInput(
              readOnly: true,
              hintText: 'e.g 0142',
              labelText: 'Invoice Number',
              controller: bloc.invoiceNumberController,
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: StandardInput(
              // onTap: () async {
              //   final selectedDate = await showDatePicker(
              //     context: context,
              //     initialDate: DateTime.now(),
              //     firstDate: DateTime(2000),
              //     lastDate: DateTime(2100),
              //   );
              //   if (selectedDate != null) {
              //     bloc.invoiceDateController.text = selectedDate.formattedDateYYYYMMDD;
              //   }
              // },
              readOnly: true,
              iconSuffix: const Icon(Icons.calendar_month),
              hintText: 'e.g yyyy-mm-dd',
              controller: bloc.invoiceDateController,
              labelText: 'Invoice Date',
            ),
          ),
        ],
      ),
    );
  }
}
