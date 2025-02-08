import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/deals/presentation/screens/deal_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/deals_list/deals_list_bloc.dart';

class DealListTile extends StatelessWidget {
  const DealListTile({super.key, required this.dealEntity});
  final DealEntity dealEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(context, DealDetailsScreen(dealId: dealEntity.id));
      },
      child: Container(
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
              text: dealEntity.dealNumber,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: dealEntity.createdAt.formattedDateMMMDDY,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: dealEntity.customer?.name ?? '-',
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: dealEntity.supplier?.name ?? '-',
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: dealEntity.customerInvoice?.goodsDescriptions.firstOrNull?.description ??
                  dealEntity.customerProforma?.goodsDescriptions.firstOrNull?.description ??
                  '-',
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: dealEntity.isComplete ? 'Completed' : 'Incomplete',
              textColor: dealEntity.isComplete ? AppColors.deepGreen : AppColors.orange,
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DeleteIconButton(
                    onPressed: () {
                      context.read<DealsListBloc>().add(DeleteDealEvent(dealId: dealEntity.id, context: context));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell({required String text, required int flex, TextStyle? style, Color? textColor}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: style ??
            TextStyles.font16Regular.copyWith(
              color: textColor ?? AppColors.secondaryOpacity50,
            ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: true,
      ),
    );
  }
}
