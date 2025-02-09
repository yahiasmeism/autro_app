import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/utils/file_utils.dart';
import 'package:autro_app/core/widgets/buttons/custom_outline_button.dart';
import 'package:autro_app/features/proformas/presentation/screens/proforma_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';

class ProformaPdfExportButton extends StatelessWidget {
  const ProformaPdfExportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerProformaFormCubit, CustomerProformaFormState>(
      builder: (context, state) {
        if (state is CustomerProformaFormLoaded && state.proformaPdfDto != null) {
          return CustomOutlineButton(
              labelText: 'Export',
              onPressed: () async {
                final filePath = await FileUtils.pickSaveLocation("PROF${state.proformaPdfDto!.proformaNumber}", 'pdf');
                if (filePath != null && context.mounted) {
                  ProformaPdfScreen.create(context, state.proformaPdfDto!, action: PdfAction.export, filePath: filePath);
                }
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
