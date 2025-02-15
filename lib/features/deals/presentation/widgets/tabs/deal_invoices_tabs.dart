import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:autro_app/features/invoices/presentation/widgets/supplier_invoice_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/no_data_screen.dart';
import '../../../../invoices/presentation/widgets/customer_invoice_list_tile.dart';

class DealInvoicesTabs extends StatelessWidget {
  const DealInvoicesTabs({super.key, required this.dealEntity});
  final DealEntity dealEntity;
  @override
  Widget build(BuildContext context) {
    final invoices = <Widget>[
      if (dealEntity.customerInvoice != null) _buildCustomerInvoice(dealEntity.customerInvoice!),
      if (dealEntity.supplierInvoiceEntity != null) ...[
        const SizedBox(height: 24),
        _buildSupplierInvoice(dealEntity.supplierInvoiceEntity!)
      ],
    ];
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: invoices.isEmpty
          ? Center(child: NoDataScreen.invoices())
          : Column(
              children: invoices,
            ),
    );
  }

  _buildCustomerInvoice(CustomerInvoiceEntity invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Invoice',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 4),
        const Divider(),
        const SizedBox(height: 4),
        CustomerInvoiceListTile(invoiceEntity: invoice),
      ],
    );
  }

  _buildSupplierInvoice(SupplierInvoiceEntity invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Supplier Invoice',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 4),
        const Divider(),
        const SizedBox(height: 4),
        SupplierInvoiceListTile(invoiceEntity: invoice),
      ],
    );
  }
}
