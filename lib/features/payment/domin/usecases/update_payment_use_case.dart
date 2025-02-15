import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/payment/domin/entities/payment_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repos/payments_repo.dart';
@lazySingleton
class UpdatePaymentUseCase extends UseCase<PaymentEntity, UpdatePaymentUseCaseParams> {
  final PaymentsRepo repo;
  UpdatePaymentUseCase(this.repo);

  @override
  Future<Either<Failure, PaymentEntity>> call(UpdatePaymentUseCaseParams params) async {
    return await repo.updatePayment(params);
  }
}

class UpdatePaymentUseCaseParams extends Equatable {
  final int paymentId;
  final double amount;
  final double prePayment;
  final DateTime date;

  const UpdatePaymentUseCaseParams(this.paymentId, this.amount, this.prePayment, this.date);
  @override
  List<Object?> get props => [paymentId, amount, prePayment, date];
}
