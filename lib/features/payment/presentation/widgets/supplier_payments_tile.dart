import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:flutter/material.dart';

import '../../domin/entities/payment_entity.dart';
import 'payment_form.dart';

class SupplierPaymentTile extends StatelessWidget {
  final PaymentEntity payment;
  final String supplierName;
  final DealEntity deal;

  const SupplierPaymentTile({super.key, required this.payment, required this.supplierName, required this.deal});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Supplier ($supplierName) Payments', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const Divider(),
        PaymentForm(deal: deal, paymentEntity: payment),
      ],
    );
  }
}
