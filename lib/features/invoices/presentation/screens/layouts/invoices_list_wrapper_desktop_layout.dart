import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/invoices/presentation/widgets/supplier_invoice_filter_search_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/customer_invoice_filter_search_bar.dart';
import '../../widgets/tabs/customer_invoice_list_tab.dart';
import '../../widgets/tabs/supplier_invoice_list_tab.dart';

class InvoicesListWrapperDesktopLayout extends StatefulWidget {
  const InvoicesListWrapperDesktopLayout({super.key});

  @override
  State<InvoicesListWrapperDesktopLayout> createState() => _InvoicesListWrapperDesktopLayoutState();
}

class _InvoicesListWrapperDesktopLayoutState extends State<InvoicesListWrapperDesktopLayout> with TickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(
      () {
        setState(() {});
      },
    );
  }

  Widget _buildSearchBar() {
    if (tabController.index == 0) {
      return const CustomerInvoiceFilterSearchBar();
    } else if (tabController.index == 1) {
      return const SupplierInvoiceFilterSearchBar();
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 24),
            CustomTabBar(
              controller: tabController,
              tabs: const ['Customer Invoices', 'Supplier Invoices'],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  CustomerInvoiceListTab(),
                  SupplierInvoiceListTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
