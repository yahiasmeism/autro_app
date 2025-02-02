import 'package:autro_app/core/extensions/bool_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/buttons/delete_outline_button.dart';
import '../../../../core/widgets/buttons/edit_outline_button.dart';

class DealDetailsActionBar extends StatelessWidget {
  const DealDetailsActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<DealDetailsCubit, DealDetailsState>(
        buildWhen: (previous, current) => current is DealDetailsLoaded,
        builder: (context, state) {
          if (state is! DealDetailsLoaded) return const SizedBox.shrink();
          return Row(
            children: [
              const Spacer(),
              DeleteOutlineButton(onPressed: () async {
                final isConfirmed = await DialogUtil.showAlertDialog(
                  context,
                  title: 'Delete Deal',
                  content: 'Are you sure you want to delete this deal?',
                );

                if (isConfirmed.isTrue && context.mounted) {
                  context.read<DealDetailsCubit>().deleteDeal();
                }
              }),
              const SizedBox(width: 16),
              state.updatedMode
                  ? SaveOutLineButton(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      onPressed: () => context.read<DealDetailsCubit>().saveDeal(),
                    )
                  : EditOutlineButton(onPressed: () => context.read<DealDetailsCubit>().editDeal()),
            ],
          );
        },
      ),
    );
  }
}
