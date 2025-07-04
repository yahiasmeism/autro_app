import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import 'package:autro_app/features/proformas/presentation/widgets/customer_proforma_pagination_bottom_bar.dart';
import 'package:autro_app/features/proformas/presentation/widgets/customer_proformas_list.dart';
import 'package:autro_app/features/proformas/presentation/widgets/customer_proformas_list_headers_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerProformasListTab extends StatelessWidget {
  const CustomerProformasListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<CustomersProformasListBloc, CustomersProformasListState>(
            listener: listener,
            builder: (context, state) {
              if (state is CustomersProformasListInitial) {
                return const LoadingIndicator();
              }
              if (state is CustomersProformasListLoaded) {
                return _buildLoadedBody(state);
              } else if (state is CustomersProformasListError) {
                return FailureScreen(
                  failure: state.failure,
                  onRetryTap: () {
                    context.read<CustomersProformasListBloc>().add(HandleFailureEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        const CustomerProformaPaginationBottomBar(),
      ],
    );
  }

  Widget _buildLoadedBody(CustomersProformasListLoaded state) {
    if (state.proformasList.isEmpty) return NoDataScreen.invoices();
    return Stack(
      children: [
        Column(
          children: [
            const CustomerProformasListHeadersRow(),
            Expanded(child: CustomerProformasList(proformas: state.proformasList)),
          ],
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  void listener(BuildContext context, CustomersProformasListState state) {
    if (state is CustomersProformasListLoaded) {
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
