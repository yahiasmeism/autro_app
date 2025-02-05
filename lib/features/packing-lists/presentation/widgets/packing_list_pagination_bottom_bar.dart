import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/packing_lists/packing_lists_bloc.dart';

class PackingListPaginationBottomBar extends StatelessWidget {
  const PackingListPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackingListsBloc, PackingListsState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is PackingListsLoaded;
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
                  context.read<PackingListsBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<PackingListsBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Packing List',
          onAddTap: isLoaded
              ? () {
                  // NavUtil.push(context, const PackingListFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
