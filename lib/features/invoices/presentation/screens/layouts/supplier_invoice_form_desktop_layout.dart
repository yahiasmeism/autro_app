import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';

import '../../widgets/supplier_invoice_form/supplier_invoice_form.dart';


class SupplierInvoiceFormDesktopLayout extends StatelessWidget {
  const SupplierInvoiceFormDesktopLayout({super.key, required this.formType});
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
            title: 'Supplier Invoice Information',
            child: SupplierInvoiceForm(),
          ),
        ),
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Supplier Invoice';
      case FormType.create:
        return 'Add New Supplier Invoice';
      default:
        return 'Supplier Invoice';
    }
  }
}
