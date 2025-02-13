import 'package:autro_app/core/constants/enums.dart';
import 'package:flutter/material.dart';

class AppNavMenuItem {
  final String title;
  final IconData icon;
  final MenuItemType type;

  AppNavMenuItem({required this.title, required this.icon, required this.type});
}

class AppMenuItems {
  static final appNavItems = [
    AppNavMenuItem(title: 'Dashboard', icon: Icons.dashboard, type: MenuItemType.dashboard),
    AppNavMenuItem(title: 'Deals', icon: Icons.local_offer, type: MenuItemType.deals),
    AppNavMenuItem(title: 'Proformas', icon: Icons.receipt_long, type: MenuItemType.proformas),
    AppNavMenuItem(title: 'Invoices', icon: Icons.receipt_long, type: MenuItemType.invoices),
    AppNavMenuItem(title: 'Suppliers', icon: Icons.people, type: MenuItemType.suppliers),
    AppNavMenuItem(title: 'Customers', icon: Icons.people, type: MenuItemType.customers),
    AppNavMenuItem(title: 'Shipping', icon: Icons.receipt, type: MenuItemType.shipping),
    AppNavMenuItem(title: 'Packing Lists', icon: Icons.receipt_long, type: MenuItemType.packingLists),
    AppNavMenuItem(title: 'BL Instructions', icon: Icons.receipt, type: MenuItemType.blInstructions),
    AppNavMenuItem(title: 'Bills', icon: Icons.receipt_long, type: MenuItemType.bills),
    AppNavMenuItem(title: 'Settings', icon: Icons.settings, type: MenuItemType.settings),
  ];
}
