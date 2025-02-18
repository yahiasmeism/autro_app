import 'package:autro_app/core/constants/enums.dart';
import 'package:equatable/equatable.dart';

class PaymentActitvityEntity extends Equatable {
  final int id;
  final DateTime date;
  final double amount;
  final double prePayment;
  final ClientType clientType;

  const PaymentActitvityEntity(
      {required this.id, required this.date, required this.amount, required this.prePayment, required this.clientType});
  @override
  List<Object?> get props => [
        id,
        date,
        amount,
        prePayment,
        clientType,
      ];

  double get remainingAmount => amount - prePayment;
}
