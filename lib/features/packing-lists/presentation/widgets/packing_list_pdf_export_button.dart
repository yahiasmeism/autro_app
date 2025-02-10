import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/utils/file_utils.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_list_form/packing_list_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'packing_list_pdf_screen.dart';

class PackingListPdfExportButton extends StatelessWidget {
  const PackingListPdfExportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackingListFormCubit, PackingListFormState>(
      builder: (context, state) {
        if (state is PackingListFormLoaded && state.packingListPdfDto != null) {
          return CustomOutlineButton(
              labelText: 'Export',
              onPressed: () async {
                final filePath =
                    await FileUtils.pickSaveLocation("PackingList-${state.packingListPdfDto!.packingListNumber}", 'pdf');
                if (filePath != null && context.mounted) {
                  PackingListPdfScreen.create(context, state.packingListPdfDto!, action: PdfAction.export, filePath: filePath);
                }
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
