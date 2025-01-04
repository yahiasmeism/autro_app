import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/generic_pagination_bottom_bar.dart';
import 'package:autro_app/features/customers/presentation/screens/customer_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/customers_list/customers_list_bloc.dart';

class CustomerPaginationBottomBar extends StatelessWidget {
  const CustomerPaginationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersListBloc, CustomersListState>(
      builder: (context, state) {
        int totalCount = 0;
        int shownCount = 0;
        bool isLoaded = state is CustomersListLoaded;
        bool canNext = false;
        bool canPrevious = false;
        if (isLoaded) {
          shownCount = state.customersList.length;
          totalCount = state.totalCount;
          canNext = state.canGoNextPage;
          canPrevious = state.canGoPreviousPage;
        }
        return GenericPaginationBottomBar(
          totalCount: totalCount,
          shownCount: shownCount,
          onPreviousTap: canPrevious
              ? () {
                  context.read<CustomersListBloc>().add(PreviousPageEvent());
                }
              : null,
          onNextTap: canNext
              ? () {
                  context.read<CustomersListBloc>().add(NextPageEvent());
                }
              : null,
          labelAddButton: 'Add New Customer',
          onAddTap: isLoaded
              ? () {
                  NavUtil.push(context, const CustomerInformationScreen(formType: FormType.create));
                }
              : null,
        );
      },
    );
  }
}
