import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/packing-lists/presentation/widgets/packing_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/packing_lists/packing_lists_bloc.dart';
import '../widgets/packing_list_filter_search_bar.dart';
import '../widgets/packing_list_pagination_bottom_bar.dart';
import '../widgets/packing_lists_headers_row.dart';

class PackingListsDesktopLayout extends StatelessWidget {
  const PackingListsDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const PackingListSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Packing Lists'),
            Expanded(
              child: BlocConsumer<PackingListsBloc, PackingListsState>(
                listener: listener,
                builder: (context, state) {
                  if (state is PackingListsInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is PackingListsLoaded) {
                    return _buildLoadedBody(state);
                  } else if (state is PackingListsError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context.read<PackingListsBloc>().add(HandleFailureEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const PackingListPaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedBody(PackingListsLoaded state) {
    if (state.packingLists.isEmpty) return NoDataScreen.packingLists();
    return Stack(
      children: [
        Column(
          children: [
            const PackingListsHeadersRow(),
            Expanded(child: PackingListsList(packingLists: state.packingLists)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, PackingListsState state) {
    if (state is PackingListsLoaded) {
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
