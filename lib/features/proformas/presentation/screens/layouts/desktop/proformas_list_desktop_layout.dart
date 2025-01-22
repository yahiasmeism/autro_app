import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/proformas/presentation/bloc/proformas_list/proformas_list_bloc.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proforma_pagination_bottom_bar.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proforma_filter_search_bar.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proformas_list.dart';
import 'package:autro_app/features/proformas/presentation/widgets/proformas_list_headers_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProformasListDesktopLayout extends StatelessWidget {
  const ProformasListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const ProformaSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Proformas'),
            Expanded(
              child: BlocConsumer<ProformasListBloc, ProformasListState>(
                listener: listener,
                builder: (context, state) {
                  if (state is ProformasListInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is ProformasListLoaded) {
                    return _buildLoadedBody(state);
                  } else if (state is ProformasListError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context.read<ProformasListBloc>().add(HandleFailureEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const ProformaPaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedBody(ProformasListLoaded state) {
    if (state.proformasList.isEmpty) return NoDataScreen.proformas();
    return Stack(
      children: [
        Column(
          children: [
            const ProformasListHeadersRow(),
            Expanded(child: ProformasList(proformas: state.proformasList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, ProformasListState state) {
    if (state is ProformasListLoaded) {
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
