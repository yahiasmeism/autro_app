import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:flutter/material.dart';

import 'layouts/desktop/supplier_details_desktop_layout.dart';

class SupplierDetailsScreen extends StatelessWidget {
  const SupplierDetailsScreen({super.key, required this.supplierEntity});
  final SupplierEntity supplierEntity;
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Suppliers Mobile Layout')),
      desktop: (context) => SupplierDetailsDesktopLayout(customerEntity: supplierEntity),
    );
  }
}
