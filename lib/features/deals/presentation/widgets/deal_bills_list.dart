import 'package:autro_app/features/deals/domin/entities/deal_bill_entity.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_bill_list_tile.dart';
import 'package:flutter/material.dart';

class DealBillsList extends StatelessWidget {
  const DealBillsList({super.key, required this.bills});
  final List<DealBillEntity> bills;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: bills.length,
      itemBuilder: (context, index) {
        return DealBillListTile(billEntity: bills[index]);
      },
    );
  }
}
