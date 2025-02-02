import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class DealLinearProgress extends StatelessWidget {
  const DealLinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    const progress = 0.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFD9D9D9),
              ),
              width: double.infinity,
              height: 10,
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.deepGreen,
                ),
                height: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'progress: ${(progress * 100).toStringAsFixed(0)}%',
          style: TextStyles.font16Regular.copyWith(color: AppColors.secondaryOpacity50),
        ),
      ],
    );
  }
}
