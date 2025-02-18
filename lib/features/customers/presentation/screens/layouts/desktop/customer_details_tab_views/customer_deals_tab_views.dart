import 'package:autro_app/core/common/domin/dto/pagination_query_payload_dto.dart';
import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/dialog_utils.dart';
import '../../../../../../../core/widgets/failure_screen.dart';
import '../../../../../../../core/widgets/loading_indecator.dart';
import '../../../../../../../core/widgets/no_data_screen.dart';
import '../../../../../../../core/widgets/overley_loading.dart';
import '../../../../../../deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import '../../../../../../deals/presentation/widgets/deal_list_headers_row.dart';
import '../../../../../../deals/presentation/widgets/deal_pagination_bottom_bar.dart';
import '../../../../../../deals/presentation/widgets/deals_list.dart';

class CustomerDealsTabViews extends StatelessWidget {
  const CustomerDealsTabViews({super.key, required this.customerId});
  final int customerId;
  @override
  Widget build(BuildContext context) {
    final filter = FilterDTO.defaultFilter().copyWith(conditions: [
      FilterConditionDTO(
        conditionOperator: ConditionOperator.equals,
        fieldName: 'customer_id',
        value: customerId.toString(),
      )
    ]);
    return BlocProvider(
      create: (context) => sl<DealsListBloc>()..add(GetDealsListEvent(filterDTO: filter)),
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<DealsListBloc, DealsListState>(
              listener: listener,
              builder: (context, state) {
                if (state is DealsListInitial) {
                  return const LoadingIndicator();
                }
                if (state is DealsListLoaded) {
                  return _buildLoadedBody(state);
                } else if (state is DealsListError) {
                  return FailureScreen(
                    failure: state.failure,
                    onRetryTap: () {
                      context.read<DealsListBloc>().add(HandleFailureEvent());
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const DealPaginationBottomBar(),
        ],
      ),
    );
  }

  Widget _buildLoadedBody(DealsListLoaded state) {
    if (state.dealsList.isEmpty) return NoDataScreen.deals();
    return Stack(
      children: [
        Column(
          children: [
            const DealsListHeadersRow(),
            Expanded(child: DealsList(deals: state.dealsList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, DealsListState state) {
    if (state is DealsListLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) => DialogUtil.showSuccessSnackBar(context, message),
        ),
      );
    }
  }
}
