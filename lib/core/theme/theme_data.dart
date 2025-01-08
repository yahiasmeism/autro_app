import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

ThemeData getTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyles.font24SemiBold,
      titleSpacing: 24,
    ),
    iconTheme: const IconThemeData(color: AppColors.iconColor),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.font16Regular.copyWith(color: AppColors.hintColor),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColors.secondaryOpacity13),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColors.secondary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColors.secondaryOpacity13),
      ),
    ),
  );
}
