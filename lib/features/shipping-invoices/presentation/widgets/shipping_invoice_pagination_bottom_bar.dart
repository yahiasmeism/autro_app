import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:autro_app/features/shipping-invoices/presentation/bloc/suppliers_list/shipping_invoices_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingInvoicePaginationBottomBar extends StatelessWidget {
  const ShippingInvoicePaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingInvoicesListBloc, ShippingInvoicesListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is ShippingInvoicesListLoaded;
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
                  context.read<ShippingInvoicesListBloc>().add(PreviousPageShippingInvoicesEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<ShippingInvoicesListBloc>().add(NextPageShippingInvoicesEvent());
                }
              : null,
          labelAddButton: 'Add New Shipping Invoice',
          onAddTap: isLoaded
              ? () {
                  // NavUtil.push(context, const ProformaFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
