import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/bl-instructions/presentation/widgets/bl_instruction_filter_search_bar.dart';
import 'package:autro_app/features/bl-instructions/presentation/widgets/bl_instruction_list_headers_row.dart';
import 'package:autro_app/features/bl-instructions/presentation/widgets/bl_instruction_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bl_instruction_list/bl_instructions_list_bloc.dart';
import '../../widgets/bl_instruction_list.dart';

class BlInsturctionsListDesktopLayout extends StatelessWidget {
  const BlInsturctionsListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const BlInstructionFilterSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'BL Instructions'),
            Expanded(
              child:
                  BlocConsumer<BlInstructionsListBloc, BlInstructionsListState>(
                listener: listener,
                builder: (context, state) {
                  if (state is BlInstructionsListInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is BlInstructionsListLoaded) {
                    return _buildLoadedBody(state);
                  } else if (state is BlInstructionsListError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context
                            .read<BlInstructionsListBloc>()
                            .add(HandleFailureBlInstructionsEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const BlInstructionPaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedBody(BlInstructionsListLoaded state) {
    if (state.blInsturctionsList.isEmpty) return NoDataScreen.blInstructions();
    return Stack(
      children: [
        Column(
          children: [
            const BlInstructionListHeadersRow(),
            Expanded(
                child: BlInstructionList(
                    shippingInvoices: state.blInsturctionsList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, BlInstructionsListState state) {
    if (state is BlInstructionsListLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(
              context, getErrorMsgFromFailure(failure)),
          (message) => DialogUtil.showSuccessSnackBar(context, message),
        ),
      );
    }
  }
}
