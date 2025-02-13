import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/buttons/cancel_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/deals/presentation/widgets/deals_list_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../bloc/bl_instruction_form/bl_instruction_bloc.dart';
import '../bloc/bl_instruction_list/bl_instructions_list_bloc.dart';
import 'bl_instruction_attachment_uploader.dart';

class BlInstructionForm extends StatelessWidget {
  const BlInstructionForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlInstructionFormBloc, BlInstructionFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is BlInstructionFormLoaded) {
          final bloc = context.read<BlInstructionFormBloc>();
          return Stack(
            children: [
              Form(
                key: bloc.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DealsListSelectionField(
                            seriesNumberController: bloc.numberController,
                            idController: bloc.dealIdController,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: StandardInput(
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (selectedDate != null) {
                                bloc.dateController.text = selectedDate.formattedDateYYYYMMDD;
                              }
                            },
                            readOnly: true,
                            iconSuffix: const Icon(Icons.calendar_month),
                            hintText: 'e.g yyyy-mm-dd',
                            controller: bloc.dateController,
                            labelText: 'Shipping Invoice Date',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const BlInstructionAttachmentUploader(),
                    const SizedBox(height: 48),
                    _buildButtons(context, state),
                  ],
                ),
              ),
              if (state.loading) const Positioned.fill(child: LoadingOverlay()),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  _buildButtons(BuildContext context, BlInstructionFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(onPressed: () => context.read<BlInstructionFormBloc>().add(CancelBlInstructionFormEvent())),
          const SizedBox(width: 16),
          ClearAllButton(
            onPressed: state.clearEnabled ? () => context.read<BlInstructionFormBloc>().add(ClearBlInstructionFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed: state.saveEnabled ? () => context.read<BlInstructionFormBloc>().add(SubmitBlInstructionFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, BlInstructionFormState state) {
    if (state is BlInstructionFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.blInstruction != null) {
              context.read<BlInstructionsListBloc>().add(AddedUpdatedBlInstructionEvent());
              context.read<DealsListBloc>().add(GetDealsListEvent());
              context.read<DealDetailsCubit>().refresh();
            }
            NavUtil.pop(context, state.blInstruction);
            DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
