import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/desktop/customers_list_desktop_layout.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Customers Mobile Layout')),
      desktop: (context) => const CustomersListDesktopLayout(),
    );
  }
}
