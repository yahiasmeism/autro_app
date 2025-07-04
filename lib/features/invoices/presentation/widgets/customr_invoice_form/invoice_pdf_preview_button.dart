import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:autro_app/features/invoices/presentation/screens/invoice_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';

class InvoicePdfPreviewButton extends StatelessWidget {
  const InvoicePdfPreviewButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInvoiceFormCubit, CustomerInvoiceFormState>(
      builder: (context, state) {
        if (state is CustomerInvoiceFormLoaded && state.invoicePdfDto != null) {
          return CustomOutlineButton(
              labelText: 'Preview PDF',
              onPressed: () {
                InvoicePdfScreen.create(context, state.invoicePdfDto!);
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
