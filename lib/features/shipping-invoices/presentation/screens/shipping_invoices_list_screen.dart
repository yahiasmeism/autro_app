import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/shipping-invoices/presentation/screens/layouts/shipping_invoices_list_desktop_layout.dart';
import 'package:flutter/material.dart';

class ShippingInvoicesListScreen extends StatelessWidget {
  const ShippingInvoicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Shipping Invoices Mobile Layout')),
      desktop: (context) => const ShippingInvoicesListDesktopLayout(),
    );
  }
}
