import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/proformas/presentation/widgets/supplier_proforma_pagination_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/suppliers_proformas_list/suppliers_proformas_list_bloc.dart';
import '../supplier_proforma_list_headers_row.dart';
import '../suppliers_proformas_list.dart';

class SupplierProformaListTab extends StatelessWidget {
  const SupplierProformaListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<SuppliersProformasListBloc, SuppliersProformasListState>(
            listener: listener,
            builder: (context, state) {
              if (state is SuppliersProformasListInitial) {
                return const LoadingIndicator();
              }
              if (state is SuppliersProformasListLoaded) {
                return _buildLoadedBody(state);
              } else if (state is SuppliersProformasListError) {
                return FailureScreen(
                  failure: state.failure,
                  onRetryTap: () {
                    context.read<SuppliersProformasListBloc>().add(HandleFailureEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        const SupplierProformaPaginationBottomBar(),
      ],
    );
  }

  Widget _buildLoadedBody(SuppliersProformasListLoaded state) {
    if (state.proformasList.isEmpty) return NoDataScreen.proformas();
    return Stack(
      children: [
        Column(
          children: [
            const SupplierProformaListHeadersRow(),
            Expanded(child: SuppliersProformasList(proformas: state.proformasList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, SuppliersProformasListState state) {
    if (state is SuppliersProformasListLoaded) {
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
