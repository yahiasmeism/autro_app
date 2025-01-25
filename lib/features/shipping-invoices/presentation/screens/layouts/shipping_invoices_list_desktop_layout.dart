import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/shipping-invoices/presentation/widgets/shipping_invoice_filter_search_bar.dart';
import 'package:autro_app/features/shipping-invoices/presentation/widgets/shipping_invoice_list.dart';
import 'package:autro_app/features/shipping-invoices/presentation/widgets/shipping_invoice_list_headers_row.dart';
import 'package:autro_app/features/shipping-invoices/presentation/widgets/shipping_invoice_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/suppliers_list/shipping_invoices_list_bloc.dart';

class ShippingInvoicesListDesktopLayout extends StatelessWidget {
  const ShippingInvoicesListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const ShippingInvoiceFilterSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Shipping Invoices'),
            Expanded(
              child: BlocConsumer<ShippingInvoicesListBloc, ShippingInvoicesListState>(
                listener: listener,
                builder: (context, state) {
                  if (state is ShippingInvoicesListInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is ShippingInvoicesListLoaded) {
                    return _buildLoadedBody(state);
                  } else if (state is ShippingInvoicesListError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context.read<ShippingInvoicesListBloc>().add(HandleFailureShippingInvoicesEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const ShippingInvoicePaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedBody(ShippingInvoicesListLoaded state) {
    if (state.shippingInvoicesList.isEmpty) return NoDataScreen.shippingInvoices();
    return Stack(
      children: [
        Column(
          children: [
            const ShippingInvoiceListHeadersRow(),
            Expanded(child: ShippingInvoiceList(shippingInvoices: state.shippingInvoicesList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, ShippingInvoicesListState state) {
    if (state is ShippingInvoicesListLoaded) {
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
