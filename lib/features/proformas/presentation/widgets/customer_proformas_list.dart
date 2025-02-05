import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:flutter/material.dart';

import 'customer_proforma_list_tile.dart';

class CustomerProformasList extends StatelessWidget {
  const CustomerProformasList({super.key, required this.proformas});
  final List<CustomerProformaEntity> proformas;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: proformas.length,
      itemBuilder: (context, index) {
        return CustomerProformaListTile(proformaEntity: proformas[index]);
      },
    );
  }
}
