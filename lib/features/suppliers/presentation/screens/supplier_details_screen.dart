import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';

import 'layouts/desktop/supplier_details_desktop_layout.dart';

class SupplierDetailsScreen extends StatelessWidget {
  const SupplierDetailsScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Suppliers Mobile Layout')),
      desktop: (context) => SupplierDetailsDesktopLayout(id: id),
    );
  }
}
