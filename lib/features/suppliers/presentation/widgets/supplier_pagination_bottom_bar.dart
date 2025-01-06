import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupplierPaginationBottomBar extends StatelessWidget {
  const SupplierPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuppliersListBloc, SuppliersListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is SuppliersListLoaded;
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
                  context.read<SuppliersListBloc>().add(PreviousPageSuppliersEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<SuppliersListBloc>().add(NextPageSuppliersEvent());
                }
              : null,
          labelAddButton: 'Add New Supplier',
          onAddTap: isLoaded
              ? () {
                  // NavUtil.push(context, const CustomerFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
