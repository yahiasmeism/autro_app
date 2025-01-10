import 'package:autro_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.labelText,
    this.bgColor,
    required this.onPressed,
    this.expended = true,
    this.child,
    this.padding,
  }) : assert(labelText != null || child != null);

  final String? labelText;
  final Color? bgColor;
  final bool expended;
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(padding ?? const EdgeInsets.all(16)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        backgroundColor: WidgetStateProperty.all(
          onPressed != null ? (bgColor ?? AppColors.secondary) : (bgColor?.withOpacity(0.5) ?? AppColors.secondaryOpacity50),
        ),
        overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
      ),
      child: child ?? Text(labelText!, style: const TextStyle(color: Colors.white)),
    );

    if (!expended) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
