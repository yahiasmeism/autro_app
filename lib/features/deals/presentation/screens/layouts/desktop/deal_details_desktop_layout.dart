import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/deals/presentation/widgets/tabs/deal_bills_tab.dart';
import 'package:autro_app/features/deals/presentation/widgets/tabs/deal_invoices_tabs.dart';
import 'package:autro_app/features/deals/presentation/widgets/tabs/deal_proformas_tab.dart';
import 'package:autro_app/features/deals/presentation/widgets/tabs/deal_shipping_invoice_tab.dart';
import 'package:autro_app/features/invoices/presentation/bloc/customers_invoices_list/customers_invoices_list_bloc.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import 'package:autro_app/features/shipping-invoices/presentation/bloc/shipping_invoice_list/shipping_invoices_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/loading_indecator.dart';
import '../../../../../../core/widgets/overley_loading.dart';
import '../../../bloc/deal_details/deal_details_cubit.dart';
import '../../../widgets/tabs/deal_overview_tab.dart';

class DealDetailsDesktopLayout extends StatefulWidget {
  const DealDetailsDesktopLayout({super.key});

  @override
  State createState() => _DealDetailsDesktopLayoutState();
}

class _DealDetailsDesktopLayoutState extends State<DealDetailsDesktopLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void blocListener(BuildContext context, DealDetailsState state) {
    if (state is DealDetailsLoaded) {
      state.updateFailureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(
              context, getErrorMsgFromFailure(failure)),
          (message) {
            DialogUtil.showSuccessSnackBar(context, message);
            context.read<DealsListBloc>().add(const GetDealsListEvent());
          },
        ),
      );

      state.deleteFailureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(
              context, getErrorMsgFromFailure(failure)),
          (message) {
            DialogUtil.showSuccessSnackBar(context, message);
            NavUtil.pop(context);
            context.read<DealsListBloc>().add(const GetDealsListEvent());
            context
                .read<CustomersProformasListBloc>()
                .add(GetProformasListEvent());
            context
                .read<CustomersInvoicesListBloc>()
                .add(GetCustomersInvoicesListEvent());
            context
                .read<ShippingInvoicesListBloc>()
                .add(GetShippingInvoicesListEvent());
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deal Details')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CustomTabBar(
              tabs: const [
                'Overview',
                'Bills',
                'Proformas',
                'Invoices',
                'Shipping Invoice',
              ],
              controller: _tabController,
            ),
            Expanded(
              child: BlocConsumer<DealDetailsCubit, DealDetailsState>(
                listener: blocListener,
                buildWhen: (previous, current) {
                  return current is DealDetailsInitial ||
                      current is DealDetailsLoaded ||
                      current is DealDetailsError;
                },
                builder: (context, state) {
                  if (state is DealDetailsInitial) {
                    return const LoadingIndicator();
                  }
                  if (state is DealDetailsLoaded) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: IndexedStack(
                            index: _tabController.index,
                            children: [
                              DealOverviewTab(state: state),
                              DealBillsListTab.create(context, state.deal.id),
                              DealProformasTab(dealEntity: state.deal),
                              DealInvoicesTabs(dealEntity: state.deal),
                              DealShippingInvoiceTab(dealEntity: state.deal),
                            ],
                          ),
                        ),
                        if (state.loading) const LoadingOverlay(),
                      ],
                    );
                  } else if (state is DealDetailsError) {
                    return Center(child: FailureScreen(failure: state.failure));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
