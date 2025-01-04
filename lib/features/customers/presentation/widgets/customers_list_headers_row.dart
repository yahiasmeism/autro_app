import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomersListHeadersRow extends StatelessWidget {
  const CustomersListHeadersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Customer Name',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Text(
              'Location',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Text(
              'Business',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 4,
            child: Text(
              'Primary Contact',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              'Deals',
              textAlign: TextAlign.center,
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              'Website',
              textAlign: TextAlign.center,
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              textAlign: TextAlign.center,
              'Actions',
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
