import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      color: AppColors.greenOpacity13,
      labelText: 'Save',
      textColor: AppColors.deepGreen,
      borderColor: AppColors.deepGreen,
      icon: SvgPicture.asset(Assets.iconsSave),
      onPressed: onPressed,
    );
  }
}
