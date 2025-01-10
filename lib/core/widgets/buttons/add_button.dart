import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, this.onAddTap, this.labelAddButton = 'Add'});
  final String labelAddButton;
  final VoidCallback? onAddTap;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: PrimaryButton(
        bgColor: AppColors.secondary,
        onPressed: onAddTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white.withOpacity(onAddTap == null ? 0.5 : 1),
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              labelAddButton,
              style: TextStyles.font16Regular.copyWith(
                color: Colors.white.withOpacity(onAddTap == null ? 0.5 : 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
