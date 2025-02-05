import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_bill_form.dart';
import 'package:flutter/material.dart';

class DealBillFormDesktopLayout extends StatelessWidget {
  const DealBillFormDesktopLayout({super.key, required this.formType});
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
            title: 'Bill Information',
            child: DealBillForm(),
          ),
        ),
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Bill';
      case FormType.create:
        return 'Add New Bill';
      default:
        return 'Bill';
    }
  }
}
