import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/bl-instructions/domin/entities/bl_insturction_entity.dart';
import 'package:autro_app/features/bl-instructions/presentation/screens/bl_instructions_form_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bl_instruction_list/bl_instructions_list_bloc.dart';

class BlInstructionListTile extends StatelessWidget {
  const BlInstructionListTile({super.key, required this.blInstructionEntity});
  final BlInsturctionEntity blInstructionEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(context, BlInsturctionFormScreen(formType: FormType.edit, id: blInstructionEntity.id));
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
              text: blInstructionEntity.number,
              flex: 4,
            ),
            const Spacer(flex: 14),
            _buildCell(
              flex: 4,
              text: blInstructionEntity.date.formattedDateMMMDDY,
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(
                    onPressed: () {
                      NavUtil.push(context, BlInsturctionFormScreen(formType: FormType.edit, id: blInstructionEntity.id));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context
                          .read<BlInstructionsListBloc>()
                          .add(DeleteBlInstructionEvent(blInsturctionId: blInstructionEntity.id));
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
