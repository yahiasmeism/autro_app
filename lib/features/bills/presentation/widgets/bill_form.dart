import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/buttons/cancel_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/bills/presentation/bloc/bill_form/bill_form_bloc.dart';
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart';
import 'package:autro_app/features/bills/presentation/widgets/bill_attachment_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillForm extends StatelessWidget {
  const BillForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BillFormBloc>();
    return BlocConsumer<BillFormBloc, BillFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is BillFormLoaded) {
          return StandardCard(
            title: 'Bill Information',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StandardInput(
                        showRequiredIndecator: true,
                        hintText: 'e.g Amazon',
                        labelText: 'Vendor',
                        controller: bloc.vendorController,
                      ),
                    ),
                    const SizedBox(width: 24),
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
                        labelText: 'Bill Date',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: StandardInput(
                        showRequiredIndecator: true,
                        hintText: 'e.g €100.00',
                        labelText: 'Amount(EUR)',
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                        controller: bloc.amountController,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: StandardInput(
                        hintText: 'e.g notes',
                        labelText: 'Notes',
                        controller: bloc.notesController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const BillAttachmentUploader(),
                const SizedBox(height: 24),
                _buildButtons(context, state),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  _buildButtons(BuildContext context, BillFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(
              onPressed: () => context.read<BillFormBloc>().add(CancelBillFormEvent()),
            ),
          SizedBox(width: state.cancelEnabled ? 16 : 0),
          ClearAllButton(
            onPressed: state.clearEnabled ? () => context.read<BillFormBloc>().add(ClearBillFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed: state.saveEnabled ? () => context.read<BillFormBloc>().add(SubmitBillFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, BillFormState state) {
    if (state is BillFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.bill != null) {
              context.read<BillsListBloc>().add(AddedUpdatedBillEvent());
            }
            NavUtil.pop(context, state.bill);
            return DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
