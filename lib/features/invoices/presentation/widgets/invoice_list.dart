import 'package:autro_app/features/invoices/domin/entities/invoice_entity.dart';
import 'package:flutter/material.dart';

import 'invoice_list_tile.dart';

class InvoicesList extends StatelessWidget {
  const InvoicesList({super.key, required this.invoices});
  final List<InvoiceEntity> invoices;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return InvoiceListTile(invoiceEntity: invoices[index]);
      },
    );
  }
}
