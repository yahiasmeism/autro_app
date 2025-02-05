import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/deals/domin/entities/deal_bill_entity.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_bills_list/deal_bills_list_bloc.dart';
import 'package:autro_app/features/deals/presentation/screens/deal_bill_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/nav_util.dart';

class DealBillListTile extends StatelessWidget {
  const DealBillListTile({super.key, required this.billEntity});
  final DealBillEntity billEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(
            context,
            DealBillFormScreen(
              dealId: billEntity.dealId,
              formType: FormType.edit,
              dealBill: billEntity,
            ));
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
              text: billEntity.vendor,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: billEntity.date.formattedDateMMMDDY,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: billEntity.amount.toStringAsFixed(2),
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: billEntity.notes,
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(
                    onPressed: () {
                      NavUtil.push(
                        context,
                        DealBillFormScreen(
                          dealId: billEntity.dealId,
                          formType: FormType.edit,
                          dealBill: billEntity,
                        ),
                      );
                    },
                  ),
                  DeleteIconButton(
                    onPressed: () {
                      context.read<DealBillsListBloc>().add(DeleteDealBillEvent(dealBillId: billEntity.id,context: context));
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
