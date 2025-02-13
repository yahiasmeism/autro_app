import 'package:autro_app/features/bl-instructions/domin/entities/bl_insturction_entity.dart';
import 'package:flutter/material.dart';

import 'bl_instruction_list_tile.dart';

class BlInstructionList extends StatelessWidget {
  const BlInstructionList({super.key, required this.shippingInvoices});
  final List<BlInsturctionEntity> shippingInvoices;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: shippingInvoices.length,
      itemBuilder: (context, index) {
        return BlInstructionListTile(blInstructionEntity: shippingInvoices[index]);
      },
    );
  }
}
