import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/deals/data/models/requests/get_deal_bills_list_request.dart';

import 'package:autro_app/features/deals/domin/entities/deal_bill_entity.dart';

import 'package:autro_app/features/deals/domin/use_cases/create_deal_bill_use_case.dart';

import 'package:autro_app/features/deals/domin/use_cases/get_deals_bills_list_use_case.dart';

import 'package:autro_app/features/deals/domin/use_cases/update_deal_bill_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domin/repositories/deals_bills_repository.dart';
import '../data_sources/remote/deals_bills_remote_data_source.dart';
import '../models/requests/create_deal_bill_request.dart';
import '../models/requests/update_deal_bill_request.dart';

@LazySingleton(as: DealsBillsRepository)
class DealBillRepositoryImpl extends DealsBillsRepository {
  final DealsBillsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _count = 0;
  DealBillRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, DealBillEntity>> createDealBill(CreateDealBillUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateDealBillRequest.fromParams(params);
        final dealBill = await remoteDataSource.createDealBill(body);
        return Right(dealBill);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDealBill(int billId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteDealBill(billId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<DealBillEntity>>> getDealsBillsList(GetDealsBillsListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = GetDealBillsListRequest.fromParams(params);
        final list = await remoteDataSource.getDealsBillsList(body);
        _count = list.total;
        return Right(list.data);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, DealBillEntity>> updateDealBill(UpdateDealBillUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateDealBillRequest.fromParams(params);
        final dealBill = await remoteDataSource.updateDealBill(body);
        return Right(dealBill);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  int get dealBillsCount => _count;
}
