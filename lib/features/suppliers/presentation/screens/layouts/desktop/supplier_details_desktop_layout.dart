import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domin/entities/supplier_entity.dart';
import '../../../bloc/supplier_details/supplier_details_cubit.dart';
import 'supplier_details_tab_views/supplier_details_overview_tab.dart';

class SupplierDetailsDesktopLayout extends StatelessWidget {
  const SupplierDetailsDesktopLayout({
    super.key,
    required this.customerEntity,
  });
  final SupplierEntity customerEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SupplierDetailsCubit>()..init(customerEntity),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Supplier Details',
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
                      SupplierDetailsOverviewTab(),
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
