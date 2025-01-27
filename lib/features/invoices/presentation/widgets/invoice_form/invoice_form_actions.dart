import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/features/invoices/domin/dtos/invoice_pdf_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons/cancel_outline_button.dart';
import '../../bloc/invoice_form/invoice_form_cubit.dart';
import '../../screens/invoice_pdf_screen.dart';

class InvoiceFormActions extends StatelessWidget {
  const InvoiceFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceFormCubit, InvoiceFormState>(
      builder: (context, state) {
        bool saveEnabled = false;
        bool updateMode = false;
        bool cancelEnabled = false;
        if (state is InvoiceFormLoaded) {
          saveEnabled = state.saveEnabled;
          updateMode = state.updatedMode;
          cancelEnabled = state.cancelEnabled;
        }
        return Row(
          children: [
            const Spacer(),
            if (cancelEnabled)
              CancelOutlineButton(
                onPressed: context.read<InvoiceFormCubit>().cancelChanges,
              ),
            const SizedBox(width: 8),
            SaveOutLineButton(
                onPressed: saveEnabled
                    ? () {
                        if (updateMode) {
                          context.read<InvoiceFormCubit>().updateInvoice();
                        } else {
                          context.read<InvoiceFormCubit>().createInvoice();
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
