import 'package:flutter/material.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';

class NoDataScreen extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final double iconSize;
  final double spacing;
  final double textFontSize;
  final Color textColor;
  final Color iconColor;
  final Gradient? backgroundGradient;

  const NoDataScreen({
    super.key,
    this.icon,
    this.text,
    this.iconSize = 150,
    this.spacing = 20,
    this.textFontSize = 24,
    this.textColor = AppColors.secondary,
    this.iconColor = AppColors.iconColor,
    this.backgroundGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.1),
          ),
          child: Icon(
            icon ?? Icons.folder,
            size: iconSize,
            color: iconColor,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          text ?? 'No Data Available',
          textAlign: TextAlign.center,
          style: TextStyles.font28SemiBold.copyWith(
            color: textColor,
            fontSize: textFontSize,
          ),
        ),
      ],
    );
  }

  factory NoDataScreen.customers() => const NoDataScreen(
        text: 'No Customers',
        icon: Icons.group,
      );
  factory NoDataScreen.suppliers() => const NoDataScreen(
        text: 'No Suppliers',
        icon: Icons.group,
      );

  factory NoDataScreen.proformas() => const NoDataScreen(
        text: 'No Proformas',
        icon: Icons.receipt,
      );

  factory NoDataScreen.invoices() => const NoDataScreen(
        text: 'No Invoices',
        icon: Icons.receipt,
      );

  factory NoDataScreen.bills() => const NoDataScreen(
        text: 'No Bills',
        icon: Icons.receipt,
      );
}
