import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entity.dart';

import 'package:flutter/material.dart';

import 'shipping_invoice_list_tile.dart';

class ShippingInvoiceList extends StatelessWidget {
  const ShippingInvoiceList({super.key, required this.shippingInvoices});
  final List<ShippingInvoiceEntity> shippingInvoices;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: shippingInvoices.length,
      itemBuilder: (context, index) {
        return ShippingInvoiceListTile(shippingInvoiceEntity: shippingInvoices[index]);
      },
    );
  }
}
