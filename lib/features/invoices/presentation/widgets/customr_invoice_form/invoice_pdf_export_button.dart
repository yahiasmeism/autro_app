import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/utils/file_utils.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:autro_app/features/invoices/presentation/screens/invoice_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';

class InvoicePdfExportButton extends StatelessWidget {
  const InvoicePdfExportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInvoiceFormCubit, CustomerInvoiceFormState>(
      builder: (context, state) {
        if (state is CustomerInvoiceFormLoaded && state.invoicePdfDto != null) {
          return CustomOutlineButton(
              labelText: 'Export',
              onPressed: () async {
                final filePath = await FileUtils.pickSaveLocation("INV${state.invoicePdfDto!.invoiceNumber}", 'pdf');
                if (filePath != null && context.mounted) {
                  InvoicePdfScreen.create(context, state.invoicePdfDto!, action: PdfAction.export, filePath: filePath);
                }
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
