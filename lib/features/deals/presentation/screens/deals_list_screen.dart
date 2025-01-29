import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/desktop/proformas_list_desktop_layout.dart';

class DealsListScreen extends StatelessWidget {
  const DealsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Deals Mobile Layout')),
      desktop: (context) => const DealsListDesktopLayout(),
    );
  }
}
