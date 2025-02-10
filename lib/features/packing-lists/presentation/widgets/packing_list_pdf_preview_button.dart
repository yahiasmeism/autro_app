import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_list_form/packing_list_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'packing_list_pdf_screen.dart';

class PackingListPdfPreviewButton extends StatelessWidget {
  const PackingListPdfPreviewButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackingListFormCubit, PackingListFormState>(
      builder: (context, state) {
        if (state is PackingListFormLoaded && state.packingListPdfDto != null) {
          return CustomOutlineButton(
              labelText: 'Preview PDF',
              onPressed: () {
                PackingListPdfScreen.create(context, state.packingListPdfDto!);
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
