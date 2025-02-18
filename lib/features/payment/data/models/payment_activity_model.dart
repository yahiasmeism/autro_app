import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/features/payment/domin/entities/payment_actitvity_entity.dart';

import '../../../../core/extensions/client_type_extension.dart';

class PaymentActivityModel extends PaymentActitvityEntity {
  const PaymentActivityModel({
    required super.id,
    required super.date,
    required super.amount,
    required super.prePayment,
    required super.clientType,
  });

  factory PaymentActivityModel.fromJson(Map<String, dynamic> json) {
    return PaymentActivityModel(
      id: (json['id'] as int?).toIntOrZero,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      amount: (json['amount'] as num?).toDoubleOrZero,
      prePayment: (json['pre_payment'] as num?).toDoubleOrZero,
      clientType: ClientTypeX.fromName((json['client_type'] as String?).orEmpty),
    );
  }
}
