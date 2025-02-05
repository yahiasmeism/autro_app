import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/desktop/proformas_list_wrapper_desktop_layout.dart';

class ProformasListWrapperScreen extends StatelessWidget {
  const ProformasListWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Proformas Mobile Layout')),
      desktop: (context) => const ProformasListWrapperDesktopLayout(),
    );
  }
}
