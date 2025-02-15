import 'package:autro_app/core/interfaces/mapable.dart';

import '../../domin/usecases/update_payment_use_case.dart';

class UpdatePaymentRequst extends UpdatePaymentUseCaseParams implements RequestMapable {
  const UpdatePaymentRequst(
    super.paymentId,
    super.amount,
    super.prePayment,
    super.date,
  );

  factory UpdatePaymentRequst.fromParams(UpdatePaymentUseCaseParams params) =>
      UpdatePaymentRequst(params.paymentId, params.amount, params.prePayment, params.date);

  @override
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'prePayment': prePayment,
      'date': date.toIso8601String(),
    };
  }
}
