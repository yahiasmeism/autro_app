import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
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
      onTap: () {},
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
              text: "Deal${dealEntity.seriesNumber}",
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
              text: dealEntity.customerProforma.customer.name,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: 'supplier',
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: dealEntity.customerProforma.goodsDescriptions.firstOrNull?.description ?? '-',
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: DeleteIconButton(
                onPressed: () {
                  context.read<DealsListBloc>().add(DeleteDealEvent(dealId: dealEntity.id));
                },
              ),
            ),
          ],
        ),
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
