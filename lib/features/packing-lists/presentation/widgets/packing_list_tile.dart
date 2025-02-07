import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_lists/packing_lists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/entities/packing_list_entity.dart';

class PackingListListTile extends StatelessWidget {
  const PackingListListTile({super.key, required this.packingListEntity});
  final PackingListEntity packingListEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        // NavUtil.push(context, PackingListFormScreen(formType: FormType.edit, packingList: packingListEntity));
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
              text: packingListEntity.number,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: packingListEntity.descriptions.firstOrNull?.date.formattedDateMMMDDY ?? '-',
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: packingListEntity.totalWeight.toStringAsFixed(2),
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: packingListEntity.descriptions.length.toString(),
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: packingListEntity.details.isEmpty ? '-' : packingListEntity.details,
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(
                    onPressed: () {
                      // NavUtil.push(context, PackingListFormScreen(formType: FormType.edit, packingList: packingListEntity));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context.read<PackingListsBloc>().add(DeletePackingListEvent(packingListId: packingListEntity.id));
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
