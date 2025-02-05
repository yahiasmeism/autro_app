import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import '../screens/customer_proforma_form_screen.dart';

class CustomerProformaPaginationBottomBar extends StatelessWidget {
  const CustomerProformaPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersProformasListBloc, CustomersProformasListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is CustomersProformasListLoaded;
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
                  context.read<CustomersProformasListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<CustomersProformasListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Customer Proforma',
          onAddTap: isLoaded
              ? () {
                  NavUtil.push(context, const ProformaFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
