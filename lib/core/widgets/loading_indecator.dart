import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.loadingMessage});
  final String? loadingMessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: 16),
        Center(child: Text(loadingMessage ?? 'Loading...', style: TextStyles.font18Regular.copyWith(color: AppColors.secondary))),
      ],
    );
  }
}
