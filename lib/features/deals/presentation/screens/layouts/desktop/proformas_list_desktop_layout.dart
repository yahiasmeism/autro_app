import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_pagination_bottom_bar.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_filter_search_bar.dart';
import 'package:autro_app/features/deals/presentation/widgets/deals_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/deal_list_headers_row.dart';

class DealsListDesktopLayout extends StatelessWidget {
  const DealsListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const DealSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Deals'),
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
