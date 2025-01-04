import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/standard_list_title.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:autro_app/features/customers/presentation/screens/layouts/desktop/widgets/customer_pagination_bottom_bar.dart';
import 'package:autro_app/features/customers/presentation/screens/layouts/desktop/widgets/customer_filter_search_bar.dart';
import 'package:autro_app/features/customers/presentation/screens/layouts/desktop/widgets/customers_list.dart';
import 'package:autro_app/features/customers/presentation/screens/layouts/desktop/widgets/customers_list_headers_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersListDesktopLayout extends StatelessWidget {
  const CustomersListDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CustomerSearchBar(),
            const SizedBox(
              height: 24,
            ),
            const StandartListTitle(title: 'Customers'),
            Expanded(
              child: BlocConsumer<CustomersListBloc, CustomersListState>(
                listener: listener,
                builder: (context, state) {
                  if (state is CustomersListInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CustomersListLoaded) {
                    if (state.loading) return const Center(child: CircularProgressIndicator());
                    if (state.customersList.isEmpty) return NoDataScreen.customers();
                    return Column(
                      children: [
                        const CustomersListHeadersRow(),
                        Expanded(child: CustomersList(customers: state.customersList)),
                      ],
                    );
                  } else if (state is CustomersListError) {
                    return FailureScreen(
                      failure: state.failure,
                      onRetryTap: () {
                        context.read<CustomersListBloc>().add(HandleFailureEvent());
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const CustomerPaginationBottomBar(),
          ],
        ),
      ),
    );
  }

  void listener(BuildContext context, CustomersListState state) {
    if (state is CustomersListLoaded) {
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
