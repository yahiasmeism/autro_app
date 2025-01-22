import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/desktop/proformas_list_desktop_layout.dart';

class ProformasListScreen extends StatelessWidget {
  const ProformasListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Proformas Mobile Layout')),
      desktop: (context) => const ProformasListDesktopLayout(),
    );
  }
}
