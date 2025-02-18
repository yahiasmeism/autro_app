import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/features/payment/domin/entities/payment_actitvity_entity.dart';

import 'package:flutter/material.dart';

class PaymentHistoryListTile extends StatelessWidget {
  final PaymentActitvityEntity paymentActitvityEntity;
  final String name;
  final String currencySymbol;

  const PaymentHistoryListTile(
      {super.key, required this.paymentActitvityEntity, required this.name, required this.currencySymbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCell(
            text: name,
            flex: 4,
          ),
          const SizedBox(width: 16),
          _buildCell(
            flex: 4,
            text: "$currencySymbol${paymentActitvityEntity.amount.toStringAsFixed(2)}",
          ),
          const SizedBox(width: 16),
          _buildCell(
            flex: 4,
            text: "$currencySymbol${paymentActitvityEntity.prePayment.toStringAsFixed(2)}",
          ),
          const SizedBox(width: 16),
          _buildCell(
            flex: 4,
            text: "$currencySymbol ${paymentActitvityEntity.remainingAmount.toStringAsFixed(2)}",
          ),
          const SizedBox(width: 16),
          _buildCell(
            flex: 4,
            text: paymentActitvityEntity.date.formattedDateMMMDDY,
          ),
        ],
      ),
    );
  }

  Widget _buildCell({required String text, required int flex, TextStyle? style}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: style ??
            TextStyles.font16Regular.copyWith(
              color: AppColors.secondaryOpacity50,
            ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: true,
      ),
    );
  }
}
