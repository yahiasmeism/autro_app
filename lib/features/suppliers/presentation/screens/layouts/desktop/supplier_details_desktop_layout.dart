import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/suppliers/presentation/screens/layouts/desktop/supplier_details_tab_views/supplier_deals_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/supplier_details/supplier_details_cubit.dart';
import 'supplier_details_tab_views/supplier_details_overview_tab.dart';

class SupplierDetailsDesktopLayout extends StatelessWidget {
  const SupplierDetailsDesktopLayout({
    super.key,
    required this.id,
  });
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SupplierDetailsCubit>()..getSupplier(id),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Supplier Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const CustomTabBar(
                  tabs: [
                    'Overview',
                    'Deals',
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SupplierDetailsOverviewTab(),
                      SupplierDealsListTab(supplierId: id),
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
