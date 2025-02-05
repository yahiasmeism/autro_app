import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_bills_list/deal_bills_list_bloc.dart';
import 'package:autro_app/features/deals/presentation/screens/deal_bill_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums.dart';

class DealBillsPaginationBottomBar extends StatelessWidget {
  const DealBillsPaginationBottomBar({super.key, required this.dealId});
  final int dealId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealBillsListBloc, DealBillsListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is DealBillsListLoaded;
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
                  context.read<DealBillsListBloc>().add(PreviousPageDealBillsEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<DealBillsListBloc>().add(NextPageDealBillsEvent());
                }
              : null,
          onAddTap: () {
            NavUtil.push(context, DealBillFormScreen(formType: FormType.create, dealId: dealId));
          },
          labelAddButton: 'Add New Bill',
          withAddTap: true,
        );
      },
    );
  }
}
