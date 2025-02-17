import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_selection_dropdown.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/payment/domin/entities/payment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/payment_form/payment_form_cubit.dart';

class PaymentForm extends StatelessWidget {
  final DealEntity deal;
  final PaymentEntity paymentEntity;

  const PaymentForm({super.key, required this.deal, required this.paymentEntity});
  @override
  Widget build(BuildContext context) {
    final cubit = sl<PaymentFormCubit>();
    return BlocProvider<PaymentFormCubit>.value(
      value: cubit..init(paymentEntity, context),
      child: BlocConsumer<PaymentFormCubit, PaymentFormState>(
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
            () {},
            (either) {
              either.fold(
                (l) {
                  DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(l));
                },
                (r) {
                  DialogUtil.showSuccessSnackBar(context, r);
                  context.read<DealsListBloc>().add(GetDealsListEvent());
                },
              );
            },
          );
        },
        bloc: cubit,
        builder: (context, state) {
          return Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StandardInput(
                      enabled: state.updateMode,
                      onTap: state.updateMode
                          ? () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (selectedDate != null) {
                                cubit.paymentDateController.text = selectedDate.formattedDateYYYYMMDD;
                              }
                            }
                          : null,
                      readOnly: true,
                      iconSuffix: const Icon(Icons.calendar_month),
                      hintText: 'e.g yyyy-mm-dd',
                      controller: cubit.paymentDateController,
                      labelText: 'Payment Date',
                    ),
                  ),
                  const SizedBox(width: 24),
                  if (items.length > 1) ...[
                    Expanded(
                      child: StandardSelectableDropdown(
                        readOnly: !state.updateMode,
                        labelText: 'Total Amount from:',
                        items: items,
                        hintText: 'Auto/Manually',
                        onChanged: (p0) {
                          if (p0 == 'Invoice') {
                            if (paymentEntity.clientType == ClientType.supplier) {
                              cubit.totalAmountController.text = deal.supplierInvoicesTotalAmount.toString();
                            } else if (paymentEntity.clientType == ClientType.customer) {
                              cubit.totalAmountController.text = deal.customerInvoice?.totalPrice.toString() ?? '';
                            }
                          } else if (p0 == 'Proforma') {
                            if (paymentEntity.clientType == ClientType.supplier) {
                              cubit.totalAmountController.text = deal.supplierProformaEntity?.totalAmount.toString() ?? '';
                            } else if (paymentEntity.clientType == ClientType.customer) {
                              cubit.totalAmountController.text = deal.customerProforma?.totalPrice.toString() ?? '';
                            }
                          }
                        },
                      ),
                    ),
                  ],
                  const SizedBox(width: 24),
                  Expanded(
                    child: StandardInput(
                      enabled: state.updateMode,
                      readOnly: !state.updateMode,
                      controller: cubit.totalAmountController,
                      labelText: 'Total Amount',
                      hintText: 'e.g 5000',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}$'))],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: StandardInput(
                      enabled: state.updateMode,
                      readOnly: !state.updateMode,
                      hintText: 'e.g 3000',
                      controller: cubit.prePaymentController,
                      labelText: 'Pre Payment',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}$'))],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: StandardInput(
                      enabled: state.updateMode,
                      readOnly: true,
                      hintText: 'e.g 3000',
                      controller: cubit.remainingAmountController,
                      labelText: 'Remaining Amount (auto)',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}$'))],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildtoggleUpdateModeButton(cubit, state),
                      if (state.updateMode) ...[const SizedBox(height: 6), _buildSaveButton(cubit, state)],
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSaveButton(PaymentFormCubit cubit, PaymentFormState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        radius: 8.0,
        onTap: () => cubit.savePayment(),
        borderRadius: BorderRadius.circular(8.0),
        child: state.saving
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SvgPicture.asset(
                  Assets.iconsSave,
                  width: 28,
                ),
              ),
      ),
    );
  }

  Widget _buildtoggleUpdateModeButton(PaymentFormCubit cubit, PaymentFormState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        radius: 8.0,
        onTap: state.saving ? null : cubit.toggleUpdateMode,
        borderRadius: BorderRadius.circular(8.0),
        child: Opacity(
          opacity: state.saving ? 0.5 : 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SvgPicture.asset(
              state.updateMode ? Assets.iconsClose : Assets.iconsEdit,
              width: 32,
            ),
          ),
        ),
      ),
    );
  }

  List<String> get items => [
        if ((deal.customerInvoice != null && paymentEntity.clientType == ClientType.customer) ||
            (deal.supplierInvoices?.isNotEmpty == true && paymentEntity.clientType == ClientType.supplier))
          'Invoice',
        if ((deal.customerProforma != null && paymentEntity.clientType == ClientType.customer) ||
            (deal.supplierProformaEntity != null && paymentEntity.clientType == ClientType.supplier))
          'Proforma',
        'Manually',
      ];
}
