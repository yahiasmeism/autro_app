import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proforama_form/proforma_pdf_export_button.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proforama_form/proforma_pdf_preview_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons/cancel_outline_button.dart';

class ProformaFormActions extends StatelessWidget {
  const ProformaFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerProformaFormCubit, CustomerProformaFormState>(
      builder: (context, state) {
        bool saveEnabled = false;
        bool updateMode = false;
        bool cancelEnabled = false;
        if (state is CustomerProformaFormLoaded) {
          saveEnabled = state.saveEnabled;
          updateMode = state.updatedMode;
          cancelEnabled = state.cancelEnabled;
        }
        return Row(
          children: [
            const Spacer(),
            if (cancelEnabled)
              CancelOutlineButton(
                onPressed: context.read<CustomerProformaFormCubit>().cancelChanges,
              ),
            const SizedBox(width: 8),
            const ProformaPdfExportButton(),
            const SizedBox(width: 8),
            const ProformaPdfPreviewButton(),
            SaveOutLineButton(
                onPressed: saveEnabled
                    ? () {
                        if (updateMode) {
                          context.read<CustomerProformaFormCubit>().updateProforma();
                        } else {
                          context.read<CustomerProformaFormCubit>().createProforma();
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
