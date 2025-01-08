import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/features/settings/widgets/upload_button.dart';
import 'package:flutter/material.dart';

class CompanyLogoUploader extends StatelessWidget {
  const CompanyLogoUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Logo',
          style: TextStyles.font16Regular,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildImage(),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UploadButton(
                  title: 'Upload Logo',
                ),
                const SizedBox(height: 8),
                Text(
                  'Recommended: 400x400px, Max 2MB',
                  style: TextStyles.font16Regular.copyWith(color: AppColors.secondaryOpacity75),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: AppColors.secondaryOpacity13),
      ),
      child: Center(
          child: Text(
        'Logo',
        style: TextStyles.font20Regular.copyWith(color: AppColors.hintColor),
      )),
    );
  }
}
