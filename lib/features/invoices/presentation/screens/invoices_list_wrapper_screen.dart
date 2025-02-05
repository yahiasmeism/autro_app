import 'package:flutter/material.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/invoices_list_wrapper_desktop_layout.dart';

class InvoicesListWrapperScreen extends StatelessWidget {
  const InvoicesListWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Invoices Mobile Layout')),
      desktop: (context) => const InvoicesListWrapperDesktopLayout(),
    );
  }
}
