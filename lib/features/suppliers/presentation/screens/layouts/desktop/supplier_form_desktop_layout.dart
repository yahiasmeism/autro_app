import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';

import '../../../widgets/supplier_form.dart';

class SupplierFormDesktopLayout extends StatelessWidget {
  const SupplierFormDesktopLayout({super.key, required this.formType});
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
            title: 'Supplier Information',
            child: SupplierForm(),
          ),
        ),
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Supplier';
      case FormType.create:
        return 'Add New Supplier';
      default:
        return 'Supplier';
    }
  }
}
