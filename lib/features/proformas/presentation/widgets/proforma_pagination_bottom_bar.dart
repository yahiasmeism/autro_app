import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/proformas_list/proformas_list_bloc.dart';
import '../screens/proforma_form_screen.dart';

class ProformaPaginationBottomBar extends StatelessWidget {
  const ProformaPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProformasListBloc, ProformasListState>(
      builder: (context, state) {
        int currentPage = 0;
        int totalPages = 0;
        bool isLoaded = state is ProformasListLoaded;
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
                  context.read<ProformasListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<ProformasListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Proforma',
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
