import 'package:autro_app/features/payment/domin/entities/payment_actitvity_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';

class PaymentEntity extends Equatable {
  final int id;
  final DateTime date;
  final double amount;
  final double prePayment;
  final ClientType clientType;
  final List<PaymentActitvityEntity> paymentActivities;

  const PaymentEntity({
    required this.id,
    required this.date,
    required this.amount,
    required this.prePayment,
    required this.clientType,
    required this.paymentActivities,
  });

  List<PaymentActitvityEntity> get customerPaymentsHistory => paymentActivities.where(
        (element) {
          return element.clientType == ClientType.customer;
        },
      ).toList();

  List<PaymentActitvityEntity> get supplierPaymentsHistory => paymentActivities.where(
        (element) {
          return element.clientType == ClientType.supplier;
        },
      ).toList();

  double get remaining => amount - prePayment;

  @override
  List<Object?> get props => [
        id,
        date,
        amount,
        prePayment,
        clientType,
        paymentActivities,
      ];
}
