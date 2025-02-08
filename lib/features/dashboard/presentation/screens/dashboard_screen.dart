import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'dashboard_desktop_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Dashboard Mobile Layout')),
      desktop: (context) => const DashboardDesktopLayout(),
    );
  }
}
