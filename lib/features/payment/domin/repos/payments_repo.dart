import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/payment_entity.dart';
import '../usecases/get_payments_use_case.dart';

abstract class PaymentsRepo {
  Future<Either<Failure, List<PaymentEntity>>> getPayments();
  Future<Either<Failure, PaymentEntity>> updatePayment(UpdatePaymentUseCaseParams params);
}