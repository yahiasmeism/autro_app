import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:autro_app/features/invoices/presentation/bloc/suppliers_invoices_list/suppliers_invoices_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/nav_util.dart';
import '../screens/supplier_invoices_form_screen.dart';

class SupplierInvoicePaginationBottomBar extends StatelessWidget {
  const SupplierInvoicePaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuppliersInvoicesListBloc, SuppliersInvoicesListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is SuppliersInvoicesListLoaded;
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
                  context.read<SuppliersInvoicesListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<SuppliersInvoicesListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Supplier Invoice',
          onAddTap: isLoaded
              ? () {
                  NavUtil.push(context, const SupplierInvoiceFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
