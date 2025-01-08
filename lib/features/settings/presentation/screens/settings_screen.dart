import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/settings/presentation/layouts/screen_settings_desktop_layout.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobile: (context) => const Center(child: Text('Settings Mobile Layout')),
      desktop: (context) => const ScreenSettingsDesktopLayout(),
    );
  }
}
