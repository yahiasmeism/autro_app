import 'package:autro_app/core/errors/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../entities/payment_entity.dart';
import '../repos/payments_repo.dart';

@lazySingleton
class GetPaymentsUseCase extends UseCase<List<PaymentEntity>, NoParams> {
  final PaymentsRepo repo;

  GetPaymentsUseCase({required this.repo});
  @override
  Future<Either<Failure, List<PaymentEntity>>> call(NoParams params) async {
    return await repo.getPayments();
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
