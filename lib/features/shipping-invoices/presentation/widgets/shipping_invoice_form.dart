import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/buttons/cancel_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_selection_dropdown.dart';
import 'package:autro_app/features/deals/presentation/widgets/deals_list_selection_field.dart';
import 'package:autro_app/features/shipping-invoices/presentation/widgets/shipping_invoice_attachment_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/shipping_invoice_form/shipping_invoice_form_bloc.dart';
import '../bloc/shipping_invoice_list/shipping_invoices_list_bloc.dart';

class ShippingInvoiceForm extends StatelessWidget {
  const ShippingInvoiceForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShippingInvoiceFormBloc, ShippingInvoiceFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is ShippingInvoiceFormLoaded) {
          final bloc = context.read<ShippingInvoiceFormBloc>();
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
                            seriesNumberController: bloc.dealSeriesNumberController,
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
                                bloc.shippingDateController.text = selectedDate.formattedDateYYYYMMDD;
                              }
                            },
                            readOnly: true,
                            iconSuffix: const Icon(Icons.calendar_month),
                            hintText: 'e.g yyyy-mm-dd',
                            controller: bloc.shippingDateController,
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
                            controller: bloc.shippingCompanyNameController,
                            labelText: 'Shipping Company Name',
                            hintText: 'Company Name',
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: StandardInput(
                            showRequiredIndecator: true,
                            controller: bloc.shippingCostController,
                            labelText: 'Total Shipping Cost',
                            hintText: '\$1,500',
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: StandardInput(
                          labelText: 'Type Material Name',
                          controller: bloc.typeMaterialNameController,
                          hintText: 'HPDE.',
                        )),
                        const SizedBox(width: 32),
                        Expanded(
                          child: StandardSelectableDropdown(
                            labelText: 'Currency',
                            hintText: 'Select currency',
                            // key: ValueKey(bloc.currencyController.text),
                            initialValue: bloc.currencyController.text.isNotEmpty ? bloc.currencyController.text : null,
                            items: const ['USD', 'EUR'],
                            onChanged: (p0) => bloc.currencyController.text = p0 ?? '',
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    const ShippingInvoiceAttachmentUploader(),
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

  _buildButtons(BuildContext context, ShippingInvoiceFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(onPressed: () => context.read<ShippingInvoiceFormBloc>().add(CancelShippingInvoiceFormEvent())),
          const SizedBox(width: 16),
          ClearAllButton(
            onPressed:
                state.clearEnabled ? () => context.read<ShippingInvoiceFormBloc>().add(ClearShippingInvoiceFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed:
                state.saveEnabled ? () => context.read<ShippingInvoiceFormBloc>().add(SubmitShippingInvoiceFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, ShippingInvoiceFormState state) {
    if (state is ShippingInvoiceFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.shippingInvoice != null) context.read<ShippingInvoicesListBloc>().add(AddedUpdatedShippingInvoiceEvent());
            NavUtil.pop(context, state.shippingInvoice);
            DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
