import 'package:autro_app/core/errors/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../entities/payment_entity.dart';
import '../repos/payments_repo.dart';

@lazySingleton
class GetPaymentsUseCase extends UseCase<List<PaymentEntity>, GetPaymentsUseCaseParams> {
  final PaymentsRepo repo;

  GetPaymentsUseCase({required this.repo});
  @override
  Future<Either<Failure, List<PaymentEntity>>> call(GetPaymentsUseCaseParams params) async {
    return await repo.getPayments(params.dealId);
  }
}

class GetPaymentsUseCaseParams extends Equatable {
  final int dealId;

  const GetPaymentsUseCaseParams({required this.dealId});

  @override
  List<Object?> get props => [dealId];
}
