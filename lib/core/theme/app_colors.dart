// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Colors from figma
  static const primary = MaterialColor(
    0xff007AFF,
    <int, Color>{
      50: Color(0xffE3F2FD),
      100: Color(0xffBBDEFB),
      200: Color(0xff90CAF9),
      300: Color(0xff64B5F6),
      400: Color(0xff42A5F5),
      500: Color(0xff2196F3),
      600: Color(0xff1E88E5),
      700: Color(0xff1976D2),
      800: Color(0xff1565C0),
      900: Color(0xff0D47A1),
    },
  );

  static const white = Color(0xffFFFFFF);
  static const secondary = Color(0xff083156);
  static const red = Color(0xffFF0000);
  static const deepGreen = Color(0xff4CAF50);
  static const orange = Color(0xffFFBB38);
  static const softBlueGray = Color(0xff8BA3CB);

  static const textTitleColor = Color(0xff343C6A);
  static const hintColor = Color(0xffBABABA);
  static const iconColor = Color(0xff718EBF);
  static const scaffoldBackgroundColor = Color(0xffF5F7FA);

  /// Opacity colors
  static Color secondaryOpacity8 = secondary.withOpacity(0.08);
  static Color secondaryOpacity13 = secondary.withOpacity(0.13);
  static Color secondaryOpacity25 = const Color(0xff083156).withOpacity(0.25);
  static Color secondaryOpacity50 = const Color(0xff083156).withOpacity(0.5);
  static Color secondaryOpacity75 = const Color(0xff083156).withOpacity(0.75);

  static Color greenOpacity13 = deepGreen.withOpacity(0.13);
  static Color greenOpacity8 = deepGreen.withOpacity(0.8);
  static Color greenOpacity50 = deepGreen.withOpacity(0.50);

  static Color primaryOpacity13 = primary.withOpacity(0.13);
  static Color primaryOpacity8 = primary.withOpacity(0.8);

  static Color orangeOpacity13 = orange.withOpacity(0.13);
  static Color orangeOpacity8 = orange.withOpacity(0.8);

  static Color redOpacity13 = red.withOpacity(0.13);
  static Color redOpacity8 = red.withOpacity(0.8);
  static Color redOpacity50 = red.withOpacity(0.50);
}
