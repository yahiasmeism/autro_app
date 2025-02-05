import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/invoices/presentation/widgets/supplier_invoice_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/suppliers_invoices_list/suppliers_invoices_list_bloc.dart';
import '../supplier_invoice_list_headers_row.dart';
import '../suppliers_invoices_list.dart';

class SupplierInvoiceListTab extends StatelessWidget {
  const SupplierInvoiceListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<SuppliersInvoicesListBloc, SuppliersInvoicesListState>(
            listener: listener,
            builder: (context, state) {
              if (state is SuppliersInvoicesListInitial) {
                return const LoadingIndicator();
              }
              if (state is SuppliersInvoicesListLoaded) {
                return _buildLoadedBody(state);
              } else if (state is SuppliersInvoicesListError) {
                return FailureScreen(
                  failure: state.failure,
                  onRetryTap: () {
                    context.read<SuppliersInvoicesListBloc>().add(HandleFailureEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        const SupplierInvoicePaginationBottomBar(),
      ],
    );
  }

  Widget _buildLoadedBody(SuppliersInvoicesListLoaded state) {
    if (state.invoicesList.isEmpty) return NoDataScreen.invoices();
    return Stack(
      children: [
        Column(
          children: [
            const SupplierInvoiceListHeadersRow(),
            Expanded(child: SuppliersInvoicesList(invoices: state.invoicesList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, SuppliersInvoicesListState state) {
    if (state is SuppliersInvoicesListLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) => DialogUtil.showSuccessSnackBar(context, message),
        ),
      );
    }
  }
}
