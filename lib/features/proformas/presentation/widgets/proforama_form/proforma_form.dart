import 'package:autro_app/features/proformas/presentation/widgets/proforama_form/proforma_form_bank_details.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proforama_form/proforma_form_delivary_terms.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proforama_form/proforma_form_good_descriptions.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proforama_form/proforma_form_shipping_details.dart';
import 'package:flutter/material.dart';

import 'proforma_form_actions.dart';
import 'proforma_form_customer_information.dart';
import 'proforma_form_details.dart';
import 'proforma_form_payment_terms.dart';

class ProformaForm extends StatelessWidget {
  const ProformaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProformaFormDetails(),
        SizedBox(height: 24),
        ProformaFormCustomerInformation(),
        SizedBox(height: 24),
        ProformaFormDelivaryTerms(),
        SizedBox(height: 24),
        ProformaFormPaymentTerms(),
        SizedBox(height: 24),
        ProformaFormGoodDescriptions(),
        SizedBox(height: 24),
        ProformaFormBankDetails(),
        SizedBox(height: 24),
        ProformaFormShippingDetails(),
        SizedBox(height: 24),
        ProformaFormActions(),
      ],
    );
  }
}
