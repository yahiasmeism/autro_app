import 'package:autro_app/features/bills/domin/entities/bill_entity.dart';
import 'package:flutter/material.dart';

import 'bill_list_tile.dart';

class BillsList extends StatelessWidget {
  const BillsList({super.key, required this.bills});
  final List<BillEntity> bills;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: bills.length,
      itemBuilder: (context, index) {
        return BillListTile(billEntity: bills[index]);
      },
    );
  }
}
