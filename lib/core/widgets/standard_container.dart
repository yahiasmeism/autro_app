import 'package:autro_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StandardContainer extends StatelessWidget {
  const StandardContainer({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: AppColors.secondaryOpacity8),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
