import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';

import '../../widgets/shipping_invoice_form.dart';

class ShippingInvoiceFormDesktopLayout extends StatelessWidget {
  const ShippingInvoiceFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: StandardCard(
            title: 'Shipping Invoice Information',
            child: ShippingInvoiceForm(),
          ),
        ),
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Shipping Invoice';
      case FormType.create:
        return 'Add New Shipping Invoice';
      default:
        return 'Shipping Invoice';
    }
  }
}
