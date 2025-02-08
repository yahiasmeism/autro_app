import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/customers/presentation/bloc/customer_details/customer_details_cubit.dart';
import 'package:autro_app/features/customers/presentation/screens/layouts/desktop/customer_details_tab_views/customer_details_overview_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetailsDesktopLayout extends StatelessWidget {
  const CustomerDetailsDesktopLayout({
    super.key,
    required this.customerId,
  });
  final int customerId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<CustomerDetailsCubit>()..getCustomer(customerId),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Customer Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                CustomTabBar(
                  tabs: [
                    'Overview',
                    'Deals',
                    'Proformas',
                    'Invoices',
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CustomerDetailsOverviewTab(),
                      Center(child: Text('Deals')),
                      Center(child: Text('Proformas')),
                      Center(child: Text('Invoices')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
