import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/desktop/suppliers_list_desktop_layout.dart';

class SuppliersListScreen extends StatelessWidget {
  const SuppliersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Suppliers Mobile Layout')),
      desktop: (context) => const SuppliersListDesktopLayout(),
    );
  }
}
