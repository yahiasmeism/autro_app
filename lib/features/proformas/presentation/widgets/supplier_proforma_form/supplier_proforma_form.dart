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
import 'package:autro_app/features/proformas/presentation/bloc/suppliers_proformas_list/suppliers_proformas_list_bloc.dart';
import 'package:autro_app/features/suppliers/presentation/widgets/supplier_list_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../../bloc/supplier_proforma_form/supplier_proforma_form_bloc.dart';
import '../supplier_proforma_attachment_uploader.dart';

class SupplierProformaForm extends StatelessWidget {
  const SupplierProformaForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplierProformaFormBloc, SupplierProformaFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is SupplierProformaFormLoaded) {
          final bloc = context.read<SupplierProformaFormBloc>();
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
                              if (deal.supplierProformaEntity != null) {
                                DialogUtil.showErrorDialog(context,
                                    content: 'This deal connected with another proforma , please select another deal');
                              }
                              // bloc.supplierIdController.text = deal.supplier?.id.toString() ?? '';
                              // bloc.supplierNameController.text = deal.supplier?.name ?? '';
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
                            labelText: 'Supplier Proforma Date',
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
                    const SupplierProformaAttachmentUploader(),
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

  _buildButtons(BuildContext context, SupplierProformaFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(onPressed: () => context.read<SupplierProformaFormBloc>().add(CancelSupplierProformaFormEvent())),
          const SizedBox(width: 16),
          ClearAllButton(
            onPressed:
                state.clearEnabled ? () => context.read<SupplierProformaFormBloc>().add(ClearSupplierProformaFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed:
                state.saveEnabled ? () => context.read<SupplierProformaFormBloc>().add(SubmitSupplierProformaFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, SupplierProformaFormState state) {
    if (state is SupplierProformaFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.supplierProforma != null) {
              context.read<SuppliersProformasListBloc>().add(AddedUpdatedSuppliersProformaEvent());
              context.read<DealsListBloc>().add(const GetDealsListEvent());
              context.read<DealDetailsCubit>().refresh();
            }
            NavUtil.pop(context, state.supplierProforma);
            DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
