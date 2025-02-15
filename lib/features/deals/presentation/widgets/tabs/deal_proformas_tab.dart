import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:flutter/material.dart';

import '../../../../proformas/presentation/widgets/customer_proforma_list_tile.dart';
import '../../../../proformas/presentation/widgets/supplier_proformas_list_tile.dart';

class DealProformasTab extends StatelessWidget {
  const DealProformasTab({super.key, required this.dealEntity});
  final DealEntity dealEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          if (dealEntity.customerProforma != null) _buildCustomerProforma(dealEntity.customerProforma!),
          if (dealEntity.supplierProformaEntity != null) ...[
            const SizedBox(height: 24),
            _buildSupplierProforma(dealEntity.supplierProformaEntity!)
          ],
        ],
      ),
    );
  }

  _buildCustomerProforma(CustomerProformaEntity proforma) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Proforma',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 4),
        const Divider(),
        const SizedBox(height: 4),
        CustomerProformaListTile(proformaEntity: proforma),
      ],
    );
  }

  _buildSupplierProforma(SupplierProformaEntity proforma) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Supplier Proforma',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 4),
        const Divider(),
        const SizedBox(height: 4),
        SupplierProformaListTile(proformaEntity: proforma),
      ],
    );
  }
}
