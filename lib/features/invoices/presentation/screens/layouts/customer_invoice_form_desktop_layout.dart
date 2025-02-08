import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/invoices/presentation/bloc/customers_invoices_list/customers_invoices_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';
import '../../widgets/customr_invoice_form/customer_invoice_form.dart';

class CustomerInvoiceFormDesktopLayout extends StatelessWidget {
  const CustomerInvoiceFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<CustomerInvoiceFormCubit, CustomerInvoiceFormState>(
        listener: (context, state) {
          if (state is CustomerInvoiceFormLoaded) {
            state.failureOrSuccessOption.fold(
              () => null,
              (either) {
                either.fold(
                  (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
                  (message) {
                    if (state.invoice != null) {
                      context.read<CustomersInvoicesListBloc>().add(AddedUpdatedCustomersInvoiceEvent());
                      context.read<DealsListBloc>().add(GetDealsListEvent());
                      context.read<DealDetailsCubit>().refresh();
                    }
                    NavUtil.pop(context, state.invoice);
                    return DialogUtil.showSuccessSnackBar(context, message);
                  },
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is CustomerInvoiceFormInitial) {
            return const LoadingOverlay();
          }
          if (state is CustomerInvoiceFormLoaded) {
            return Stack(
              children: [
                const Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CustomerInvoiceForm(),
                    ),
                  ),
                ),
                if (state.loading) const LoadingOverlay(),
              ],
            );
          } else if (state is CustomerInvoiceFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<CustomerInvoiceFormCubit>().handleError();
              },
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
