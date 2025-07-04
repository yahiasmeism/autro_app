import 'package:autro_app/core/extensions/client_type_extension.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/payment/domin/entities/payment_entity.dart';

import 'payment_activity_model.dart';

class PaymentModel extends PaymentEntity implements BaseMapable {
  const PaymentModel({
    required super.id,
    required super.date,
    required super.amount,
    required super.prePayment,
    required super.clientType,
    required super.paymentActivities,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
        id: (json['id'] as int?).toIntOrZero,
        date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
        amount: (json['amount'] as num?).toDoubleOrZero,
        prePayment: (json['pre_payment'] as num?).toDoubleOrZero,
        clientType: ClientTypeX.fromName((json['client_type'] as String?).orEmpty),
        paymentActivities: List<PaymentActivityModel>.of([
          if (json['payment_activities'] != null)
            ...json['payment_activities']
                .map<PaymentActivityModel>((activity) => PaymentActivityModel.fromJson(activity))
                .toList(),
        ]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'prePayment': prePayment,
      'clientType': clientType,
    };
  }
}
