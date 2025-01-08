// ignore_for_file: deprecated_member_use

import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/text_styles.dart';

class SaveScoundaryButton extends StatelessWidget {
  const SaveScoundaryButton({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      expended: false,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.iconsSave,
              color: AppColors.white,
            ),
            const SizedBox(width: 16),
            Text(
              'Save',
              style: TextStyles.font16Regular.copyWith(color: AppColors.white),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
