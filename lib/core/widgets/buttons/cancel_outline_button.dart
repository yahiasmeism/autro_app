import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CancelOutlineButton extends StatelessWidget {
  const CancelOutlineButton({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      labelText: 'Cancel',
      onPressed: onPressed,
      icon: const Icon(
        Icons.close,
        color: AppColors.secondary,
      ),
    );
  }
}
