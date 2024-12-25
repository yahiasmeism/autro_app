import 'package:autro_app/features/customers/presentation/screens/layouts/customers_desktop_layout.dart';
import 'package:autro_app/features/customers/presentation/screens/layouts/customers_mobile_layout.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const CustomersMobileLayout(),
      desktop: (context) => const CustomersDesktopLayout(),
    );
  }
}
