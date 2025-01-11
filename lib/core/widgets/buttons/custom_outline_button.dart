import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {super.key,
      this.icon,
      this.onPressed,
      this.color,
      this.textColor,
      this.iconColor,
      this.borderColor,
      required this.labelText,
      this.padding});
  final Widget? icon;
  final void Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final String labelText;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color?.withOpacity(0.08) ?? AppColors.secondaryOpacity8,
          padding: padding ?? (const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
          textStyle: (TextStyles.font16Regular.copyWith(color: textColor ?? AppColors.secondary)),
          overlayColor: (color?.withOpacity(0.1) ?? AppColors.secondaryOpacity8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          side: BorderSide(
            color: (onPressed != null ? borderColor : borderColor?.withOpacity(0.50)) ??
                color?.withOpacity(0.13) ??
                AppColors.secondaryOpacity13,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Opacity(
                  opacity: onPressed != null ? 1 : 0.50,
                  child: icon!,
                ),
              ),
            Text(labelText,
                style: TextStyles.font16Regular.copyWith(
                  color: onPressed != null
                      ? (textColor ?? AppColors.secondary)
                      : (textColor ?? AppColors.secondary).withOpacity(0.5),
                )),
          ],
        ));
  }
}
