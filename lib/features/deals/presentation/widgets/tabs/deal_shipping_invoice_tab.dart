import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:flutter/material.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entity.dart';

import '../../../../../core/widgets/no_data_screen.dart';
import '../../../../shipping-invoices/presentation/widgets/shipping_invoice_list_tile.dart';

class DealShippingInvoiceTab extends StatelessWidget {
  const DealShippingInvoiceTab({super.key, required this.dealEntity});
  final DealEntity dealEntity;
  @override
  Widget build(BuildContext context) {
    final shippingInvoices = <Widget>[
      if (dealEntity.shippingInvoice != null)
        _buildShippingInvoice(dealEntity.shippingInvoice!),
    ];
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: shippingInvoices.isEmpty
          ? Center(child: NoDataScreen.shippingInvoices())
          : Column(
              children: shippingInvoices,
            ),
    );
  }

  _buildShippingInvoice(ShippingInvoiceEntity shippingInvoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Invoice',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 4),
        const Divider(),
        const SizedBox(height: 4),
        ShippingInvoiceListTile(shippingInvoiceEntity: shippingInvoice),
      ],
    );
  }
}
