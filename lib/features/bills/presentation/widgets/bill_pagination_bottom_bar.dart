import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:autro_app/features/bills/presentation/screens/bill_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bills_list/bills_list_bloc.dart';

class BillPaginationBottomBar extends StatelessWidget {
  const BillPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsListBloc, BillsListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is BillsListLoaded;
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
                  context.read<BillsListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<BillsListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Bill',
          onAddTap: isLoaded
              ? () {
                  NavUtil.push(context, const BillFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
