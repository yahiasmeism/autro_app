import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/features/invoices/domin/dtos/invoice_pdf_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons/cancel_outline_button.dart';
import '../../../invoices/presentation/screens/invoice_pdf_screen.dart';

import '../bloc/packing_list_form/packing_list_form_cubit.dart';

class PackingListFormActions extends StatelessWidget {
  const PackingListFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackingListFormCubit, PackingListFormState>(
      listener: (context, state) {
        if (state is PackingListFormLoaded) {
          state.failureOrSuccessOption.fold(
            () => null,
            (a) {
              a.fold(
                (l) {
                  DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(l));
                },
                (r) {
                  DialogUtil.showSuccessSnackBar(context, r);
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        bool saveEnabled = false;
        bool updateMode = false;
        bool cancelEnabled = false;
        if (state is PackingListFormLoaded) {
          saveEnabled = state.saveEnabled;
          updateMode = state.updatedMode;
          cancelEnabled = state.cancelEnabled;
        }
        return Row(
          children: [
            const Spacer(),
            if (cancelEnabled)
              CancelOutlineButton(
                onPressed: context.read<PackingListFormCubit>().cancelChanges,
              ),
            const SizedBox(width: 8),
            SaveOutLineButton(
                onPressed: saveEnabled
                    ? () {
                        if (updateMode) {
                          context.read<PackingListFormCubit>().updatePackingList();
                        } else {
                          context.read<PackingListFormCubit>().createPackingList();
                        }
                      }
                    : null),
            const SizedBox(width: 8),
            CustomOutlineButton(
              labelText: 'Preview PDF',
              onPressed: () => InvoicePdfScreen.create(
                context,
                // TODO should be handle
                InvoicePdfDto(),
              ),
            ),
          ],
        );
      },
    );
  }
}
