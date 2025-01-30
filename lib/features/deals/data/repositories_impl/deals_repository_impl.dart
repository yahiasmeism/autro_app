import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/deals/data/data_sources/remote/deals_remote_data_source.dart';

import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';

import 'package:autro_app/features/deals/domin/use_cases/create_deal_use_case.dart';

import 'package:autro_app/features/deals/domin/use_cases/get_deals_list_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/data/requests/pagination_list_request.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domin/repositories/deals_repository.dart';
import '../../domin/use_cases/update_deal_use_case.dart';
import '../models/requests/create_deal_request.dart';
import '../models/requests/get_proformas_list_request.dart';
import '../models/requests/update_deal_request.dart';

@LazySingleton(as: DealsRepository)
class DealsRepositoryImpl extends DealsRepository {
  final DealsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _totalCount = 0;
  DealsRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, DealEntity>> createDeal(CreateDealUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateDealRequest(customerProformaId: params.customerProformaId);
        final deal = await remoteDataSource.createDeal(body);
        return Right(deal);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDeal(int dealId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteDeal(dealId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, DealEntity>> getDealById(int dealId) async {
    if (await networkInfo.isConnected) {
      try {
        final deal = await remoteDataSource.getDealById(dealId);
        return Right(deal);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<DealEntity>>> getDealsList(GetDealsListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
        final body = GetDealsListRequest(paginationFilterRequest: paginationFilterBody);
        final paginationList = await remoteDataSource.getDealsList(body);
        _totalCount = paginationList.total;
        return Right(paginationList.data);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, DealEntity>> updateDeal(UpdateDealUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateDealRequest.fromParams(params);
        final updatedDeal = await remoteDataSource.updateDeal(body);
        return Right(updatedDeal);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  int get totalCount => _totalCount;
}
