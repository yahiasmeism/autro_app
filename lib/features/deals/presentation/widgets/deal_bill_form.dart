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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/deal_bill_form/deal_bill_form_bloc.dart';
import '../bloc/deal_bills_list/deal_bills_list_bloc.dart';
import '../bloc/deal_details/deal_details_cubit.dart';
import 'deal_bill_attachment_uploader.dart';

class DealBillForm extends StatelessWidget {
  const DealBillForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DealBillFormBloc, DealBillFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is DealBillFormLoaded) {
          final bloc = context.read<DealBillFormBloc>();
          return Stack(
            children: [
              Form(
                key: bloc.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: StandardInput(
                          labelText: 'Vendor',
                          controller: bloc.vendorController,
                          hintText: 'Vendor Name',
                        )),
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
                    Row(
                      children: [
                        Expanded(
                          child: StandardInput(
                            showRequiredIndecator: true,
                            controller: bloc.amountController,
                            labelText: 'Total Amount',
                            hintText: '€1,500',
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: StandardInput(
                            showRequiredIndecator: true,
                            controller: bloc.notesController,
                            labelText: 'Notes',
                            hintText: 'Notes',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const DealBillAttachmentUploader(),
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

  _buildButtons(BuildContext context, DealBillFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(onPressed: () => context.read<DealBillFormBloc>().add(CancelDealBillFormEvent())),
          const SizedBox(width: 16),
          ClearAllButton(
            onPressed: state.clearEnabled ? () => context.read<DealBillFormBloc>().add(ClearDealBillFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed: state.saveEnabled ? () => context.read<DealBillFormBloc>().add(SubmitDealBillFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, DealBillFormState state) {
    if (state is DealBillFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.dealBill != null) {
              context.read<DealBillsListBloc>().add(AddedUpdatedDealBillEvent());
              context.read<DealsListBloc>().add(GetDealsListEvent());
              context.read<DealDetailsCubit>().refresh();
            }
            NavUtil.pop(context, state.dealBill);
            DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
