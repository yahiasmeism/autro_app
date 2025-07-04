import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';

import 'layouts/desktop/customer_details_desktop_layout.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key, required this.customerId});
  final int customerId;
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Customers Mobile Layout')),
      desktop: (context) => CustomerDetailsDesktopLayout(customerId: customerId),
    );
  }
}
