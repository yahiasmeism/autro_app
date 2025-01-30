import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/nav_util.dart';
import '../bloc/customers_invoices_list/customers_invoices_list_bloc.dart';
import '../screens/custoemr_invoice_form_screen.dart';

class InvoicePaginationBottomBar extends StatelessWidget {
  const InvoicePaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersInvoicesListBloc, CustomersInvoicesListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is CustomersInvoicesListLoaded;
        final loadingPagination = isLoaded && state.loadingPagination;
        bool canNext = false;
        bool canPrevious = false;
        if (isLoaded) {
          currentPage = state.paginationFilterDTO.pageNumber;
          totalPages = (state.totalCount / state.paginationFilterDTO.pageSize).ceil();
          canNext = state.canGoNextPage;
          canPrevious = state.canGoPreviousPage;
        }
        return GenericPaginationBottomBar(
          isLoading: loadingPagination,
          pagesCount: totalPages,
          currentPage: currentPage,
          onPreviousTap: canPrevious
              ? () {
                  context.read<CustomersInvoicesListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<CustomersInvoicesListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Invoice',
          onAddTap: isLoaded
              ? () {
                  NavUtil.push(context, const CustomerInvoiceFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
