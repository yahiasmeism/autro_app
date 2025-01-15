import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/settings/presentation/layouts/tabs/bank_accounts_tab.dart';
import 'package:autro_app/features/settings/presentation/layouts/tabs/company_information_tab.dart';
import 'package:autro_app/features/settings/presentation/layouts/tabs/invoice_settings_tab.dart';
import 'package:flutter/material.dart';

import 'tabs/user_management_tab.dart';

class ScreenSettingsDesktopLayout extends StatelessWidget {
  const ScreenSettingsDesktopLayout({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Setttings',
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
                  'Company Information',
                  'Bank Accountes',
                  'User Management',
                  'Invoice Settings',
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CompanyInformationTab(),
                    BankAccountsTab(),
                    UserManagementTab(),
                    InvoiceSettingsTab(),
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
