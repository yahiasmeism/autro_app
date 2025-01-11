import 'package:flutter/material.dart';

import 'loading_indecator.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
