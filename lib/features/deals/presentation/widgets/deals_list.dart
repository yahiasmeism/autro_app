import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:flutter/material.dart';

import 'deal_list_tile.dart';

class DealsList extends StatelessWidget {
  const DealsList({super.key, required this.deals});
  final List<DealEntity> deals;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: deals.length,
      itemBuilder: (context, index) {
        return DealListTile(dealEntity: deals[index]);
      },
    );
  }
}
