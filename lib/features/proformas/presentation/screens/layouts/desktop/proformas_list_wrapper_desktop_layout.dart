import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/proformas/presentation/widgets/customer_proforma_filter_search_bar.dart';
import 'package:autro_app/features/proformas/presentation/widgets/supplier_proforma_filter_search_bar.dart';
import 'package:flutter/material.dart';

import '../../../widgets/tabs/customer_proformas_list_tab.dart';
import '../../../widgets/tabs/supplier_proforma_list_tab.dart';

class ProformasListWrapperDesktopLayout extends StatefulWidget {
  const ProformasListWrapperDesktopLayout({super.key});

  @override
  State<ProformasListWrapperDesktopLayout> createState() => _ProformasListWrapperDesktopLayoutState();
}

class _ProformasListWrapperDesktopLayoutState extends State<ProformasListWrapperDesktopLayout> with TickerProviderStateMixin {
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
      return const CustomerProformaSearchBar();
    } else if (tabController.index == 1) {
      return const SupplierProformaFilterSearchBar();
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
              tabs: const ['Customer proformas', 'Supplier proformas'],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  CustomerProformasListTab(),
                  SupplierProformaListTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
