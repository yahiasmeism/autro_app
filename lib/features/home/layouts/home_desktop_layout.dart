import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/features/bills/presentation/screens/bills_list_screen.dart';
import 'package:autro_app/features/bl-instructions/presentation/screens/bl_instructions_list_screen.dart';
import 'package:autro_app/features/customers/presentation/screens/customers_list_screen.dart';
import 'package:autro_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:autro_app/features/deals/presentation/screens/deals_list_screen.dart';
import 'package:autro_app/features/home/bloc/home_bloc.dart';
import 'package:autro_app/features/home/widget/custom_drawer.dart';
import 'package:autro_app/features/packing-lists/presentation/screen/packing_lists_screen.dart';
import 'package:autro_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:autro_app/features/shipping-invoices/presentation/screens/shipping_invoices_list_screen.dart';
import 'package:autro_app/features/suppliers/presentation/screens/suppliers_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../invoices/presentation/screens/invoices_list_wrapper_screen.dart';
import '../../proformas/presentation/screens/proformas_list_wrapper_screen.dart';

class HomeWrapperDesktopLayout extends StatelessWidget {
  const HomeWrapperDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            width: 300,
            child: CustomDrawer(),
          ),
          Expanded(
            flex: 8,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return _buildSelectedScreen(context, state);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedScreen(BuildContext context, HomeLoaded state) {
    final screens = <MenuItemType, Widget>{
      MenuItemType.dashboard: _buildNavigator(const Center(child: DashboardScreen())),
      MenuItemType.invoices: _buildNavigator(const InvoicesListWrapperScreen()),
      MenuItemType.deals: _buildNavigator(Center(child: DealsListScreen(key: UniqueKey()))),
      MenuItemType.proformas: _buildNavigator(const ProformasListWrapperScreen()),
      MenuItemType.customers: _buildNavigator(const CustomersListScreen()),
      MenuItemType.shipping: _buildNavigator(const Center(child: ShippingInvoicesListScreen())),
      MenuItemType.blInstructions: _buildNavigator(const BlInsturctionsListScreen()),
      MenuItemType.settings: _buildNavigator(const SettingsScreen()),
      MenuItemType.bills: _buildNavigator(const Center(child: BillsListScreen())),
      MenuItemType.suppliers: _buildNavigator(const SuppliersListScreen()),
      MenuItemType.packingLists: _buildNavigator(const PackingListsScreen()),
    };
    return IndexedStack(
      sizing: StackFit.expand,
      index: screens.keys.toList().indexOf(state.selectedItem.type),
      children: screens.values.toList(),
    );
  }

  Widget _buildNavigator(Widget child) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => child,
      ),
    );
  }
}
