import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/invoices/presentation/bloc/invoices_list/invoices_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/invoice_form/invoice_form_cubit.dart';
import '../../widgets/invoice_form/invoice_form.dart';


class InvoiceFormDesktopLayout extends StatelessWidget {
  const InvoiceFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<InvoiceFormCubit, InvoiceFormState>(
        listener: (context, state) {
          if (state is InvoiceFormLoaded) {
            state.failureOrSuccessOption.fold(
              () => null,
              (either) {
                either.fold(
                  (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
                  (message) {
                    if (state.invoice != null) context.read<InvoicesListBloc>().add(AddedUpdatedInvoiceEvent());
                    NavUtil.pop(context, state.invoice);
                    return DialogUtil.showSuccessSnackBar(context, message);
                  },
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is InvoiceFormLoaded) {
            return Stack(
              children: [
                const Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: InvoiceForm(),
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
        return 'Edit Invoice';
      case FormType.create:
        return 'Add New Invoice';
      default:
        return 'Invoice';
    }
  }
}
