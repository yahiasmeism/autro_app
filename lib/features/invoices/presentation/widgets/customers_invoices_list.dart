import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:flutter/material.dart';

import 'customer_invoice_list_tile.dart';

class CustomersInvoicesList extends StatelessWidget {
  const CustomersInvoicesList({super.key, required this.invoices});
  final List<CustomerInvoiceEntity> invoices;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return CustomerInvoiceListTile(invoiceEntity: invoices[index]);
      },
    );
  }
}
