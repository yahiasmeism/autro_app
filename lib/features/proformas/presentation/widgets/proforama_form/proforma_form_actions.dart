import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/buttons/cancel_outline_button.dart';

class ProformaFormActions extends StatelessWidget {
  const ProformaFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProformaFormCubit, CustomerProformaFormState>(
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
                onPressed: context.read<ProformaFormCubit>().cancelChanges,
              ),
            const SizedBox(width: 8),
            SaveOutLineButton(
                onPressed: saveEnabled
                    ? () {
                        if (updateMode) {
                          context.read<ProformaFormCubit>().updateProforma();
                        } else {
                          context.read<ProformaFormCubit>().createProforma();
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
