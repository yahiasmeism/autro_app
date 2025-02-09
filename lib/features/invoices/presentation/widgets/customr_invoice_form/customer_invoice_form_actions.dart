import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/features/invoices/presentation/widgets/customr_invoice_form/invoice_pdf_preview_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons/cancel_outline_button.dart';
import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';
import 'invoice_pdf_export_button.dart';

class CustomerInvoiceFormActions extends StatelessWidget {
  const CustomerInvoiceFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInvoiceFormCubit, CustomerInvoiceFormState>(
      builder: (context, state) {
        bool saveEnabled = false;
        bool updateMode = false;
        bool cancelEnabled = false;
        if (state is CustomerInvoiceFormLoaded) {
          saveEnabled = state.saveEnabled;
          updateMode = state.updatedMode;
          cancelEnabled = state.cancelEnabled;
        }
        return Row(
          children: [
            const Spacer(),
            if (cancelEnabled)
              CancelOutlineButton(
                onPressed: context.read<CustomerInvoiceFormCubit>().cancelChanges,
              ),
            const SizedBox(width: 8),
            const InvoicePdfExportButton(),
            const SizedBox(width: 8),
            const InvoicePdfPreviewButton(),
            const SizedBox(width: 8),
            SaveOutLineButton(
                onPressed: saveEnabled
                    ? () {
                        if (updateMode) {
                          context.read<CustomerInvoiceFormCubit>().updateInvoice();
                        } else {
                          context.read<CustomerInvoiceFormCubit>().createInvoice();
                        }
                      }
                    : null),
            // const SizedBox(width: 8),
          ],
        );
      },
    );
  }
}
