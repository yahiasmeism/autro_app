import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class GenericPaginationBottomBar extends StatelessWidget {
  const GenericPaginationBottomBar({
    super.key,
    required this.labelAddButton,
    this.onNextTap,
    this.onPreviousTap,
    required this.onAddTap,
    required this.currentPage,
    required this.pagesCount,
    this.isLoading = false,
  });

  final String labelAddButton;
  final int currentPage, pagesCount;
  final Function()? onNextTap, onPreviousTap, onAddTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildGenericAddButton(),
          const Spacer(),
          _buildPageInfoWithLoading(),
          const SizedBox(width: 16),
          _buildPaginationButtons(),
        ],
      ),
    );
  }

  Widget _buildGenericAddButton() {
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

  Widget _buildPageInfoWithLoading() {
    return Row(
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: isLoading
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 14),
        Text(
          'Page $currentPage of $pagesCount',
          style: TextStyles.interFont15Regular,
        ),
      ],
    );
  }

  Widget _buildPaginationButtons() {
    return Row(
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(AppColors.secondaryOpacity8),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.secondaryOpacity25,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
            ),
          ),
          onPressed: isLoading ? null : onPreviousTap,
          child: Text(
            'previous',
            style: TextStyles.font16Regular.copyWith(
              color: isLoading || onPreviousTap == null ? AppColors.secondaryOpacity50 : null,
            ),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: isLoading ? null : onNextTap,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(AppColors.secondaryOpacity8),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.secondaryOpacity25,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
          ),
          child: Text(
            'next',
            style: TextStyles.font16Regular.copyWith(
              color: isLoading || onNextTap == null ? AppColors.secondaryOpacity50 : null,
            ),
          ),
        ),
      ],
    );
  }
}
