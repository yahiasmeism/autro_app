import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/invoices/presentation/widgets/invoice_pagination_bottom_bar.dart';
import 'package:autro_app/features/invoices/presentation/widgets/invoice_filter_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/invoices_list/invoices_list_bloc.dart';
import '../../widgets/invoice_list.dart';
import '../../widgets/invoice_list_headers_row.dart';

class InvoicesListDesktopLayout extends StatelessWidget {
  const InvoicesListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const InvoiceSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Invoices'),
            Expanded(
              child: BlocConsumer<InvoicesListBloc, InvoicesListState>(
                listener: listener,
                builder: (context, state) {
                  if (state is InvoicesListInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is InvoicesListLoaded) {
                    return _buildLoadedBody(state);
                  } else if (state is InvoicesListError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context.read<InvoicesListBloc>().add(HandleFailureEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const InvoicePaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedBody(InvoicesListLoaded state) {
    if (state.invoicesList.isEmpty) return NoDataScreen.invoices();
    return Stack(
      children: [
        Column(
          children: [
            const InvoicesListHeadersRow(),
            Expanded(child: InvoicesList(invoices: state.invoicesList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, InvoicesListState state) {
    if (state is InvoicesListLoaded) {
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
