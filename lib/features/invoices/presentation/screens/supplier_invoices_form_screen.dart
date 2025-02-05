import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/entities/supplier_invoice_entity.dart';
import '../bloc/supplier_invoice_form/supplier_invoice_form_bloc.dart';
import 'layouts/supplier_invoice_form_desktop_layout.dart';

class SupplierInvoiceFormScreen extends StatelessWidget {
  const SupplierInvoiceFormScreen({super.key, this.supplierInvoice, required this.formType});
  final SupplierInvoiceEntity? supplierInvoice;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SupplierInvoiceFormBloc>()..add(InitialSupplierInvoiceFormEvent(supplierInvoice: supplierInvoice)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Supplier Invoices Mobile Layout'),
        ),
        desktop: (context) => SupplierInvoiceFormDesktopLayout(formType: formType),
      ),
    );
  }
}
