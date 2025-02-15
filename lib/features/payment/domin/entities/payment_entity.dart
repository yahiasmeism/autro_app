import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';

class PaymentEntity extends Equatable {
  final int id;
  final DateTime date;
  final double amount;
  final double prePayment;
  final ClientType clientType;

  const PaymentEntity({
    required this.id,
    required this.date,
    required this.amount,
    required this.prePayment,
    required this.clientType,
  });

  double get remaining => amount - prePayment;

  @override
  List<Object?> get props => [
    id,
    date,
    amount,
    prePayment,
    clientType,
  ];
}
