import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';

import '../../../widgets/tabs/deal_overview_tab.dart';

class DealDetailsDesktopLayout extends StatelessWidget {
  const DealDetailsDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deal Details')),
      body: const DefaultTabController(
        length: 5,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              CustomTabBar(
                tabs: [
                  'Overview',
                  'Proformas',
                  'Invoices',
                  'Packing Lists',
                  'Bills',
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    DealOverviewTab(),
                    Center(child: Text('Proformas')),
                    Center(child: Text('Invoices')),
                    Center(child: Text('Packing Lists')),
                    Center(child: Text('Bills')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
