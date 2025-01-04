import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class StandartListTitle extends StatelessWidget {
  final String title;

  const StandartListTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          color: AppColors.secondaryOpacity13,
          height: 2,
          child: const Divider(),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.primary, width: 2)),
              ),
              child: Text(title,
                  style: TextStyles.font20Regular.copyWith(
                    color: AppColors.primary,
                  )),
            )),
      ],
    );
  }
}
