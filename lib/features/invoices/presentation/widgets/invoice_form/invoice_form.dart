import 'package:flutter/material.dart';

import 'invoice_form_actions.dart';
import 'invoice_form_bank_details.dart';
import 'invoice_form_customer_information.dart';
import 'invoice_form_details.dart';
import 'invoice_form_good_descriptions.dart';
import 'invoice_form_proforma_details.dart';
import 'invoice_form_shipping_details.dart';

class InvoiceForm extends StatelessWidget {
  const InvoiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InvoiceFormProformaDetails(),
        SizedBox(height: 24),
        InvoiceFormDetails(),
        SizedBox(height: 24),
        InvoiceFormCustomerInformation(),
        SizedBox(height: 24),
        InvoiceFormGoodDescriptions(),
        SizedBox(height: 24),
        InvoiceFormBankDetails(),
        SizedBox(height: 24),
        InvoiceFormShippingDetails(),
        SizedBox(height: 24),
        InvoiceFormActions(),
      ],
    );
  }
}
