import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/deals_list/deals_list_bloc.dart';

class DealPaginationBottomBar extends StatelessWidget {
  const DealPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealsListBloc, DealsListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is DealsListLoaded;
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
                  context.read<DealsListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<DealsListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Deal',
          withAddTap: false,
        );
      },
    );
  }
}
