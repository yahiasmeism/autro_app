import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:flutter/material.dart';

import 'supplier_invoice_list_tile.dart';

class SuppliersInvoicesList extends StatelessWidget {
  const SuppliersInvoicesList({super.key, required this.invoices});
  final List<SupplierInvoiceEntity> invoices;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return SupplierInvoiceListTile(invoiceEntity: invoices[index]);
      },
    );
  }
}
