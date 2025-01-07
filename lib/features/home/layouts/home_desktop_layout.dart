import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/features/customers/presentation/screens/customers_list_screen.dart';
import 'package:autro_app/features/home/bloc/home_bloc.dart';
import 'package:autro_app/features/home/widget/custom_drawer.dart';
import 'package:autro_app/features/suppliers/presentation/screens/suppliers_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedScreen(BuildContext context, HomeLoaded state) {
    final screens = <MenuItemType, Widget>{
      MenuItemType.dashboard: _buildNavigator(const Center(child: Text('Dashboard'))),
      MenuItemType.invoices: _buildNavigator(const Center(child: Text('Invoices'))),
      MenuItemType.deals: _buildNavigator(const Center(child: Text('Deals'))),
      MenuItemType.proformas: _buildNavigator(const Center(child: Text('Proformas'))),
      MenuItemType.customers: _buildNavigator(const CustomersListScreen()),
      MenuItemType.accounting: _buildNavigator(const Center(child: Text('Accounting'))),
      MenuItemType.shipping: _buildNavigator(const Center(child: Text('Shipping'))),
      MenuItemType.settings: _buildNavigator(const Center(child: Text('Settings'))),
      MenuItemType.bills: _buildNavigator(const Center(child: Text('Bills'))),
      MenuItemType.suppliers: _buildNavigator(const SuppliersListScreen()),
      MenuItemType.messages: _buildNavigator(const Center(child: Text('Messages'))),
    };

    return IndexedStack(
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
