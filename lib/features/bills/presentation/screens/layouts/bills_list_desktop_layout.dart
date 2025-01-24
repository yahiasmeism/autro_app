import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart';
import 'package:autro_app/features/bills/presentation/widgets/bill_pagination_bottom_bar.dart';
import 'package:autro_app/features/bills/presentation/widgets/bill_filter_search_bar.dart';
import 'package:autro_app/features/bills/presentation/widgets/bills_summary_top_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/bill_list.dart';
import '../../widgets/bill_list_headers_row.dart';

class BillsListDesktopLayout extends StatelessWidget {
  const BillsListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const BillsSummaryTopSection(),
            const SizedBox(
              height: 24,
            ),
            const BillSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Bills'),
            Expanded(
              child: BlocConsumer<BillsListBloc, BillsListState>(
                listener: listener,
                builder: (context, state) {
                  if (state is BillsListInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is BillsListLoaded) {
                    return _buildLoadedBody(state);
                  } else if (state is BillsListError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context.read<BillsListBloc>().add(HandleFailureEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const BillPaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedBody(BillsListLoaded state) {
    if (state.billsList.isEmpty) return NoDataScreen.bills();
    return Stack(
      children: [
        Column(
          children: [
            const BillsListHeadersRow(),
            Expanded(child: BillsList(bills: state.billsList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, BillsListState state) {
    if (state is BillsListLoaded) {
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
