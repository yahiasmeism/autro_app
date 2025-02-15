import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/payment/domin/entities/payment_entity.dart';
import 'package:autro_app/features/payment/presentation/widgets/payment_form.dart';
import 'package:flutter/material.dart';

class CustomerPaymentTile extends StatelessWidget {
  final PaymentEntity payment;
  final String customerName;
  final DealEntity dealEntity;

  const CustomerPaymentTile({super.key, required this.payment, required this.customerName, required this.dealEntity});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer ($customerName) Payments',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const Divider(),
        PaymentForm(deal: dealEntity, paymentEntity: payment),
      ],
    );
  }
}
