import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';

import 'layouts/bl_instructions_list_desktop_layout.dart';

class BlInsturctionsListScreen extends StatelessWidget {
  const BlInsturctionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Bl Instructions Mobile Layout')),
      desktop: (context) => const BlInsturctionsListDesktopLayout(),
    );
  }
}
