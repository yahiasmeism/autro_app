import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/presentation/widgets/supplier_list_tile.dart';
import 'package:flutter/material.dart';


class SuppliersList extends StatelessWidget {
  const SuppliersList({super.key, required this.suppliers});
  final List<SupplierEntity> suppliers;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: suppliers.length,
      itemBuilder: (context, index) {
        return SupplierListTile(supplierEntity: suppliers[index]);
      },
    );
  }
}
