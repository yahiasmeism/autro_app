import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class StandardCard extends StatelessWidget {
  const StandardCard({super.key, required this.child, required this.title, this.padding});
  final Widget child;
  final String title;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    const radius = 8.0;
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: AppColors.secondaryOpacity8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
              color: AppColors.secondaryOpacity8,
            ),
            child: Text(
              title,
              style: TextStyles.font20Regular,
            ),
          ),
          Flexible(
            child: Padding(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
