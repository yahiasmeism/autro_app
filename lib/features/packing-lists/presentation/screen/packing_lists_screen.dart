import 'package:autro_app/features/packing-lists/presentation/screen/packing_lists_screen_desktop_layout.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';

class PackingListsScreen extends StatelessWidget {
  const PackingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Packing Lists Mobile Layout')),
      desktop: (context) => const PackingListsDesktopLayout(),
    );
  }
}
