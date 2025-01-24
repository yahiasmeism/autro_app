import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons/cancel_outline_button.dart';
import '../../bloc/invoice_form/invoice_form_cubit.dart';

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
          ],
        );
      },
    );
  }
}
