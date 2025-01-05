import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/screens/layouts/desktop/customer_details_tab_views/customer_details_overview_tab.dart';
import 'package:flutter/material.dart';

class CustomerDetailsDesktopLayout extends StatelessWidget {
  const CustomerDetailsDesktopLayout({super.key, required this.customer});
  final CustomerEntity customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Customer Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              const CustomTabBar(
                tabs: [
                  'Overview',
                  'Deals',
                  'Proformas',
                  'Invoices',
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CustomerDetailsOverviewTab(customerEntity: customer),
                    const Center(child: Text('Deals')),
                    const Center(child: Text('Proformas')),
                    const Center(child: Text('Invoices')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
