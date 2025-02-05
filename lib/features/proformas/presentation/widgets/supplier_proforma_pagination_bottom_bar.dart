import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:autro_app/features/proformas/presentation/bloc/suppliers_proformas_list/suppliers_proformas_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/nav_util.dart';
import '../screens/supplier_proformas_form_screen.dart';

class SupplierProformaPaginationBottomBar extends StatelessWidget {
  const SupplierProformaPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuppliersProformasListBloc, SuppliersProformasListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is SuppliersProformasListLoaded;
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
                  context.read<SuppliersProformasListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<SuppliersProformasListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Supplier Proforma',
          onAddTap: isLoaded
              ? () {
                  NavUtil.push(context, const SupplierProformaFormScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
