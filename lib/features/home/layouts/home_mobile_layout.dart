import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/enums.dart';
import '../../customers/presentation/screens/customers_list_screen.dart';
import '../bloc/home_bloc.dart';
import '../widget/custom_drawer.dart';

class HomeMobileLayout extends StatefulWidget {
  const HomeMobileLayout({super.key});

  @override
  State<HomeMobileLayout> createState() => _HomeMobileLayoutState();
}

class _HomeMobileLayoutState extends State<HomeMobileLayout> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      drawer: CustomDrawer(scaffoldKey: scaffoldKey),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return _buildSelectedScreen(context, state);
          }
          return const Center(child: SizedBox.shrink());
        },
      ),
    );
  }

  Widget _buildSelectedScreen(BuildContext context, HomeLoaded state) {
    final screens = <MenuItemType, Widget>{
      MenuItemType.customers: const CustomersListScreen(),
      MenuItemType.dashboard: const Center(child: Text('Dashboard')),
      MenuItemType.invoices: const Center(child: Text('Invoices')),
      MenuItemType.deals: const Center(child: Text('Deals')),
      MenuItemType.shipping: const Center(child: Text('Shipping')),
      MenuItemType.settings: const Center(child: Text('Settings')),
      MenuItemType.bills: const Center(child: Text('Bills')),
      MenuItemType.suppliers: const Center(child: Text('Suppliers')),
      // MenuItemType.messages: const Center(child: Text('Messages')),
    };

    return IndexedStack(
      index: screens.keys.toList().indexOf(state.selectedItem.type),
      children: screens.values.toList(),
    );
  }
}
