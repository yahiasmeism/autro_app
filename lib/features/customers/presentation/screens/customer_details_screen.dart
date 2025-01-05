import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:flutter/material.dart';

import 'layouts/desktop/customer_details_desktop_layout.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key, required this.customerEntity});
  final CustomerEntity customerEntity;
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Customers Mobile Layout')),
      desktop: (context) => CustomerDetailsDesktopLayout(customer: customerEntity),
    );
  }
}
