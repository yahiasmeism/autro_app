// ignore_for_file: deprecated_member_use

import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditOutlineButton extends StatelessWidget {
  const EditOutlineButton({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      borderColor: AppColors.secondaryOpacity50,
      color: AppColors.secondaryOpacity50,
      labelText: 'Edit',
      icon: SvgPicture.asset(
        Assets.iconsEdit,
        color: AppColors.secondary,
      ),
      onPressed: onPressed,
    );
  }
}
