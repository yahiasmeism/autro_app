import 'package:flutter/material.dart';

import 'customer_invoice_form_actions.dart';
import 'customer_invoice_form_bank_details.dart';
import 'customer_invoice_form_customer_information.dart';
import 'customer_invoice_form_details.dart';
import 'customer_invoice_form_good_descriptions.dart';
import 'customer_invoice_form_shipping_details.dart';

class CustomerInvoiceForm extends StatelessWidget {
  const CustomerInvoiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomerInvoiceFormDetails(),
        SizedBox(height: 24),
        CustomerInvoiceFormCustomerInformation(),
        SizedBox(height: 24),
        CustomerInvoiceFormGoodDescriptions(),
        SizedBox(height: 24),
        CustomerInvoiceFormBankDetails(),
        SizedBox(height: 24),
        CustomerInvoiceFormShippingDetails(),
        SizedBox(height: 24),
        CustomerInvoiceFormActions(),
      ],
    );
  }
}
