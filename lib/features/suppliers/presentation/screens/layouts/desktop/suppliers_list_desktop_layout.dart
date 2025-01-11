import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/supplier_filter_search_bar.dart';
import '../../../widgets/supplier_list_header_row.dart';
import '../../../widgets/supplier_pagination_bottom_bar.dart';
import '../../../widgets/suppliers_list.dart';

class SuppliersListDesktopLayout extends StatelessWidget {
  const SuppliersListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SupplierFilterSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Suppliers'),
            Expanded(
              child: BlocConsumer<SuppliersListBloc, SuppliersListState>(
                listener: listener,
                builder: (context, state) {
                  if (state is SuppliersListInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is SuppliersListLoaded) {
                    return _buildLoadedBody(state);
                  } else if (state is SuppliersListError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context.read<SuppliersListBloc>().add(HandleFailureSuppliersEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SupplierPaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedBody(SuppliersListLoaded state) {
    if (state.suppliersList.isEmpty) return NoDataScreen.suppliers();
    return Stack(
      children: [
        Column(
          children: [
            const SupplierListHeaderRow(),
            Expanded(child: SuppliersList(suppliers: state.suppliersList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, SuppliersListState state) {
    if (state is SuppliersListLoaded) {
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
