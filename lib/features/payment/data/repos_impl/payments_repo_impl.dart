import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/payment/data/data_sources/payments_remote_data_sources.dart';
import 'package:autro_app/features/payment/data/requests/update_payment_requst.dart';

import 'package:autro_app/features/payment/domin/entities/payment_entity.dart';


import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domin/repos/payments_repo.dart';
import '../../domin/usecases/update_payment_use_case.dart';

@LazySingleton(as: PaymentsRepo)
class PaymentsRepoImpl extends PaymentsRepo {
  final PaymentsRemoteDataSources paymentsRemoteDataSources;
  final NetworkInfo networkInfo;

  PaymentsRepoImpl({required this.paymentsRemoteDataSources, required this.networkInfo});
  @override
  Future<Either<Failure, List<PaymentEntity>>> getPayments(int dealId) async {
    if (await networkInfo.isConnected) {
      try {
        final payments = await paymentsRemoteDataSources.getPayments(dealId);
        return Right(payments);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, PaymentEntity>> updatePayment(UpdatePaymentUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdatePaymentRequst.fromParams(params);
        final payment = await paymentsRemoteDataSources.updatePayment(body);
        return Right(payment);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
