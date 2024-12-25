import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const textColor = Color(0xff083156);
  static const textTitleColor = Color(0xff343C6A);
  static Color textColor50Opacity = const Color(0xff083156).withOpacity(0.5);
  static Color textColor75Opacity = const Color(0xff083156).withOpacity(0.75);
  static const redColor = Color(0xffFF0000);
  static const deepGreen = Color(0xff4CAF50);
  static Color orangeColor = const Color(0xffFFBB38);

  static Color standartBodrderColor = const Color(0xff083156).withOpacity(0.08);
  static Color redBorderColor = const Color(0xffFF0000).withOpacity(0.50);
  static Color greenBorderColor = const Color(0xff4CAF50).withOpacity(0.50);
  static Color fieldBodrderColor = const Color(0xff083156).withOpacity(0.13);

  static Color hintFieldColor = const Color(0xffBABABA);
  static Color hintColor = const Color(0xffBABABA);
  static Color fillColor = const Color(0xffF5F7FA);
  static Color iconColor = const Color(0xff718EBF);
  static Color iconBorderColor = const Color(0xff083156).withOpacity(0.25);
  static const scaffoldBackgroundColor = Color(0xffF5F7FA);

  static Color backgroundGreenTrasparent = const Color(0xff4CAF50).withOpacity(0.13);
  static Color backgroundBlueTrasparent = const Color(0xff007AFF).withOpacity(0.13);
  static Color backgroundBlueTrasparent2 = const Color(0xff007AFF).withOpacity(0.8);
  static Color backgroundYellowTrasparent = const Color(0xffFFBB38).withOpacity(0.13);
  static Color backgroundYellowTrasparent2 = const Color(0xffFFBB38).withOpacity(0.8);
  static Color backgroundRedTrasparent = const Color(0xffFF0000).withOpacity(0.13);
  static Color backgroundRedTrasparent2 = const Color(0xffFF0000).withOpacity(0.8);

  static const MaterialColor primary = MaterialColor(
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
}
