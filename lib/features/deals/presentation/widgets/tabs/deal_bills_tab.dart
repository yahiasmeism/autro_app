import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_bill_filter_search_bar.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_bills_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/overley_loading.dart';
import '../../bloc/deal_bills_list/deal_bills_list_bloc.dart';
import '../deal_bills_list.dart';

class DealBillsListTab extends StatelessWidget {
  const DealBillsListTab._();

  static Widget create(BuildContext context,int dealId) {
    return BlocProvider.value(
      value: context.read<DealBillsListBloc>()..add(GetDealBillsListEvent(dealId: dealId)),
      child: const DealBillsListTab._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealBillsListBloc, DealBillsListState>(
      builder: (context, state) {
        if (state is DealBillsListInitial) {
          return const LoadingIndicator();
        } else if (state is DealBillsListLoaded) {
          return Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const DealBillFilterSearchBar(),
                    const SizedBox(height: 16),
                    if (state.dealBillsList.isNotEmpty)
                      Expanded(
                        child: DealBillsList(
                          bills: state.dealBillsList,
                        ),
                      )
                    else
                      Expanded(child: NoDataScreen.bills()),
                    const SizedBox(height: 16),
                    DealBillsPaginationBottomBar(dealId: state.dealId),
                  ],
                ),
              ),
              if (state.loading) const LoadingOverlay(),
            ],
          );
        } else if (state is DealBillsListError) {
          return FailureScreen(
            failure: state.failure,
            onRetryTap: () => context.read<DealBillsListBloc>().add(
                  HandleFailureDealBillsEvent(),
                ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
