import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:flutter/material.dart';

import 'supplier_proformas_list_tile.dart';

class SuppliersProformasList extends StatelessWidget {
  const SuppliersProformasList({super.key, required this.proformas});
  final List<SupplierProformaEntity> proformas;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: proformas.length,
      itemBuilder: (context, index) {
        return SupplierProformaListTile(proformaEntity: proformas[index]);
      },
    );
  }
}
