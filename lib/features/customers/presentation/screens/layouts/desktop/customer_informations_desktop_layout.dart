import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';

import 'widgets/customer_form.dart';

class CustomerInformationsDesktopLayout extends StatelessWidget {
  const CustomerInformationsDesktopLayout({super.key, required this.formType});
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
            title: 'Customer Information',
            child: CustomerForm(),
          ),
        ),
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Customer';
      case FormType.view:
        return 'Customer Details';
      case FormType.create:
        return 'Add New Customer';
      default:
        return 'Customer';
    }
  }
}
