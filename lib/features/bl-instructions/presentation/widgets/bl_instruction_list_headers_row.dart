import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class BlInstructionListHeadersRow extends StatelessWidget {
  const BlInstructionListHeadersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeaderCell('Connected Deal', 4),
          const Spacer(flex: 14),
          _buildHeaderCell('Date', 4),
          const SizedBox(width: 16),
          _buildHeaderCell('Actions', 4, isCenter: true),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, int flex, {bool isCenter = false}) {
    return Expanded(
      flex: flex,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: TextStyles.font16Regular.copyWith(
            color: AppColors.secondaryOpacity50,
            fontWeight: FontWeight.w500,
          ),
          maxLines: null,
          softWrap: true,
        ),
      ),
    );
  }
}
