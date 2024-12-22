import 'package:autro_app/features/home/bloc/app_nav_menu_item.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final AppNavMenuItem item;
  final bool isSelected;
  final Function(AppNavMenuItem item) onSelect;

  const DrawerItem({super.key, required this.item, required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
        onTap: () => onSelect(item),
        style: ListTileStyle.drawer,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        selected: isSelected,
        selectedColor: Colors.white,
        selectedTileColor: Theme.of(context).colorScheme.primary,
        leading: Icon(
          item.icon,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
