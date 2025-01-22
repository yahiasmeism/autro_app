import 'package:autro_app/features/proformas/domin/entities/proforma_entity.dart';
import 'package:flutter/material.dart';

import 'proforma_list_tile.dart';

class ProformasList extends StatelessWidget {
  const ProformasList({super.key, required this.proformas});
  final List<ProformaEntity> proformas;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: proformas.length,
      itemBuilder: (context, index) {
        return ProformaListTile(proformaEntity: proformas[index]);
      },
    );
  }
}
