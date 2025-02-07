import 'package:flutter/material.dart';

import '../../domin/entities/packing_list_entity.dart';
import 'packing_list_tile.dart';

class PackingListsList extends StatelessWidget {
  const PackingListsList({super.key, required this.packingLists});
  final List<PackingListEntity> packingLists;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: packingLists.length,
      itemBuilder: (context, index) {
        return PackingListListTile(packingListEntity: packingLists[index]);
      },
    );
  }
}
