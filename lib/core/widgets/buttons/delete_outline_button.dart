import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeleteOutlineButton extends StatelessWidget {
  const DeleteOutlineButton({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      borderColor: AppColors.red,
      color: AppColors.red,
      textColor: AppColors.red,
      labelText: 'Delete',
      icon: SvgPicture.asset(Assets.iconsDelete),
      onPressed: onPressed,
    );
  }
}
