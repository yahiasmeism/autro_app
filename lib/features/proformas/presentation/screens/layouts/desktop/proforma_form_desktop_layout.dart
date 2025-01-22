import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/proformas/presentation/bloc/cubit/proforma_form_cubit.dart';
import 'package:autro_app/features/proformas/presentation/bloc/proformas_list/proformas_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/proforama_form/proforma_form.dart';

class ProformaFormDesktopLayout extends StatelessWidget {
  const ProformaFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<ProformaFormCubit, ProformaFormState>(
        listener: (context, state) {
          if (state is ProformaFormLoaded) {
            state.failureOrSuccessOption.fold(
              () => null,
              (either) {
                either.fold(
                  (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
                  (message) {
                    if (state.proforma != null) context.read<ProformasListBloc>().add(AddedUpdatedProformaEvent());
                    NavUtil.pop(context, state.proforma);
                    return DialogUtil.showSuccessSnackBar(context, message);
                  },
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is ProformaFormLoaded) {
            return Stack(
              children: [
                const Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: ProformaForm(),
                    ),
                  ),
                ),
                if (state.loading) const LoadingOverlay(),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Proforma';
      case FormType.create:
        return 'Add New Proforma';
      default:
        return 'Proforma';
    }
  }
}
