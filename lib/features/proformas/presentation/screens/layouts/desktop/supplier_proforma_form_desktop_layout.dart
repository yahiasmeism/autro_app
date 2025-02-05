import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';

import '../../../widgets/supplier_proforma_form/supplier_proforma_form.dart';


class SupplierProformaFormDesktopLayout extends StatelessWidget {
  const SupplierProformaFormDesktopLayout({super.key, required this.formType});
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
            title: 'Supplier Proforma Information',
            child: SupplierProformaForm(),
          ),
        ),
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Supplier Proforma';
      case FormType.create:
        return 'Add New Supplier Proforma';
      default:
        return 'Supplier Proforma';
    }
  }
}
