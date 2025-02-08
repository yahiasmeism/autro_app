import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/supplier_invoice_form/supplier_invoice_form_bloc.dart';
import 'layouts/supplier_invoice_form_desktop_layout.dart';

class SupplierInvoiceFormScreen extends StatelessWidget {
  const SupplierInvoiceFormScreen({super.key, this.supplierInvoiceId, required this.formType});
  final int? supplierInvoiceId;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SupplierInvoiceFormBloc>()..add(InitialSupplierInvoiceFormEvent(id: supplierInvoiceId)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Supplier Invoices Mobile Layout'),
        ),
        desktop: (context) => SupplierInvoiceFormDesktopLayout(formType: formType),
      ),
    );
  }
}
