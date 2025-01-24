import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/bills_list_desktop_layout.dart';

class BillsListScreen extends StatelessWidget {
  const BillsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Bills Mobile Layout')),
      desktop: (context) => const BillsListDesktopLayout(),
    );
  }
}
