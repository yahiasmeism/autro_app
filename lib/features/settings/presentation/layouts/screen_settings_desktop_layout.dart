import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/settings/presentation/layouts/tabs/company_information_tab.dart';
import 'package:flutter/material.dart';

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
          length: 5,
          child: Column(
            children: [
              CustomTabBar(
                tabs: [
                  'Company Information',
                  'Bank Accountes',
                  'Preferences',
                  'User Management',
                  'System Settings',
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
                    Center(child: Text('Bank Accountes')),
                    Center(child: Text('Preferences')),
                    Center(child: Text('User Management')),
                    Center(child: Text('System Settings')),
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
