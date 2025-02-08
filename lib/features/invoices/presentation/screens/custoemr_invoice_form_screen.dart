import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';
import 'layouts/customer_invoice_form_desktop_layout.dart';

class CustomerInvoiceFormScreen extends StatelessWidget {
  const CustomerInvoiceFormScreen({super.key, this.invoiceId, required this.formType});
  final int? invoiceId;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CustomerInvoiceFormCubit>()..init(invoiceId: invoiceId),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Invoices Mobile Layout'),
        ),
        desktop: (context) => CustomerInvoiceFormDesktopLayout(formType: formType),
      ),
    );
  }
}
