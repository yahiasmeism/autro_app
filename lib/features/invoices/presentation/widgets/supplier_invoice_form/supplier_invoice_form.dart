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
import 'package:autro_app/features/invoices/presentation/bloc/suppliers_invoices_list/suppliers_invoices_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_selection_dropdown.dart';
import '../../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../../../../suppliers/presentation/widgets/supplier_list_selection_field.dart';
import '../../bloc/supplier_invoice_form/supplier_invoice_form_bloc.dart';
import '../supplier_invoice_attachment_uploader.dart';

class SupplierInvoiceForm extends StatelessWidget {
  const SupplierInvoiceForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplierInvoiceFormBloc, SupplierInvoiceFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is SupplierInvoiceFormLoaded) {
          final bloc = context.read<SupplierInvoiceFormBloc>();
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
                            seriesNumberController: bloc.dealNumberController,
                            idController: bloc.dealIdController,
                            onItemTap: (deal) {
                              bloc.supplierIdController.text = deal.supplier?.id.toString() ?? '';
                              bloc.supplierNameController.text = deal.supplier?.name ?? '';
                              if (deal.supplier != null) {
                                bloc.supplierIdController.text = deal.supplier!.id.toString();
                                bloc.supplierNameController.text = deal.supplier!.name;
                              }
                            },
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
                            labelText: 'Supplier Invoice Date',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: SuppliersListSelectionField(
                            idController: bloc.supplierIdController,
                            nameController: bloc.supplierNameController,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: StandardInput(
                            showRequiredIndecator: true,
                            controller: bloc.totalAmountController,
                            labelText: 'total amount',
                            hintText: '€1,500',
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
                        const Expanded(
                            child: StandardInput(
                          labelText: 'Currency',
                          initialValue: 'EUR',
                          readOnly: true,
                        ))
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: SupplierInvoiceAttachmentUploader()),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StandardSelectableDropdown(
                            onChanged: (p0) {
                              bloc.statusController.text = p0 ?? '';
                            },
                            items: const ['Pending', 'Sent'],
                            hintText: 'e.g yyyy-mm-dd',
                            initialValue: bloc.statusController.text.isEmpty ? 'Pending' : bloc.statusController.text,
                            labelText: 'Status',
                          ),
                        ),
                      ],
                    ),
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

  _buildButtons(BuildContext context, SupplierInvoiceFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(onPressed: () => context.read<SupplierInvoiceFormBloc>().add(CancelSupplierInvoiceFormEvent())),
          const SizedBox(width: 16),
          ClearAllButton(
            onPressed:
                state.clearEnabled ? () => context.read<SupplierInvoiceFormBloc>().add(ClearSupplierInvoiceFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed:
                state.saveEnabled ? () => context.read<SupplierInvoiceFormBloc>().add(SubmitSupplierInvoiceFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, SupplierInvoiceFormState state) {
    if (state is SupplierInvoiceFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.supplierInvoice != null) {
              context.read<SuppliersInvoicesListBloc>().add(AddedUpdatedSuppliersInvoiceEvent());
              context.read<DealsListBloc>().add(const GetDealsListEvent());
              context.read<DealDetailsCubit>().refresh();
            }
            NavUtil.pop(context, state.supplierInvoice);
            DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
