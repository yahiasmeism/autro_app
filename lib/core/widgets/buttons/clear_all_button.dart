import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClearAllButton extends StatelessWidget {
  const ClearAllButton({super.key, required this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      color: AppColors.redOpacity13,
      labelText: 'Clear All',
      textColor: AppColors.red,
      borderColor: AppColors.red,
      icon: SvgPicture.asset(Assets.iconsClearAll),
      onPressed: onPressed,
    );
  }
}
