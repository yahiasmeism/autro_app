import 'package:autro_app/core/constants/assets.dart';

import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key, this.title = 'Upload', required this.onTap});
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryOpacity13),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(Assets.iconsUpload),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyles.montserratFont16Medium,
            ),
          ],
        ),
      ),
    );
  }
}
