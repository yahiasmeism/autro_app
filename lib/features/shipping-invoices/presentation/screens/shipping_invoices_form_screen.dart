import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/entities/shipping_invoice_entites.dart';
import '../bloc/shipping_invoice_form/shipping_invoice_form_bloc.dart';
import 'layouts/shipping_invoices_form_desktop_layout.dart';

class ShippingInvoiceFormScreen extends StatelessWidget {
  const ShippingInvoiceFormScreen({super.key, this.shippingInvoice, required this.formType});
  final ShippingInvoiceEntity? shippingInvoice;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ShippingInvoiceFormBloc>()..add(InitialShippingInvoiceFormEvent(shippingInvoice: shippingInvoice)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Shipping Invoices Mobile Layout'),
        ),
        desktop: (context) => ShippingInvoiceFormDesktopLayout(formType: formType),
      ),
    );
  }
}
