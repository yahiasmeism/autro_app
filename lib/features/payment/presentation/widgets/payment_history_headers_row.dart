import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class PaymentHistoryHeadersRow extends StatelessWidget {
  const PaymentHistoryHeadersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: AppColors.secondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeaderCell('Name', 4),
          const SizedBox(width: 16),
          _buildHeaderCell('Total Amount', 4),
          const SizedBox(width: 16),
          _buildHeaderCell('Piad Amount', 4),
          const SizedBox(width: 16),
          _buildHeaderCell('Remaining Amount', 4),
          const SizedBox(width: 16),
          _buildHeaderCell('Date', 4),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, int flex, {bool isCenter = false}) {
    return Flexible(
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
          // overflow: TextOverflow.ellipsis,
          maxLines: null,
          softWrap: true,
        ),
      ),
    );
  }
}
