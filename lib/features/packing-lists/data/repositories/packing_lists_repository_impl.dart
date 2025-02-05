import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/packing-lists/data/data_sources/packing_lists_remote_data_source.dart';
import 'package:autro_app/features/packing-lists/data/model/requests/get_all_packing_lists_request.dart';

import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';

import 'package:autro_app/features/packing-lists/domin/use_cases/create_packing_list_use_case.dart';

import 'package:autro_app/features/packing-lists/domin/use_cases/get_all_packing_lists_use_case.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/update_packing_list_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domin/reposetories/packing_lists_repository.dart';
import '../model/requests/create_packing_list_request.dart';
import '../model/requests/update_packing_list_request.dart';

@LazySingleton(as: PackingListsRepository)
class PackingListsRepositoryImpl extends PackingListsRepository {
  final PackingListsRemoteDataSource packingListsRemoteDataSource;
  final NetworkInfo networkInfo;
  int _count = 0;
  PackingListsRepositoryImpl({required this.packingListsRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, PackingListEntity>> createPackingList(CreatePackingListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreatePackingListRequest.fromParams(params);
        final result = await packingListsRemoteDataSource.createPackingList(body);
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePackingList(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await packingListsRemoteDataSource.deletePackingList(id);
        return const Right(unit);
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, PackingListEntity>> getPackingList(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await packingListsRemoteDataSource.getPackingList(id);
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<PackingListEntity>>> getPackingLists(GetAllPackingListsUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = GetAllPackingListsRequest(paginationFilterDTO: params.paginationFilterDTO);
        final paginationList = await packingListsRemoteDataSource.getPackingLists(body);
        _count = paginationList.total;
        return Right(paginationList.data);
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  int get totalCount => _count;

  @override
  Future<Either<Failure, PackingListEntity>> updatePackingList(UpdatePackingListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdatePackingListRequest.fromParams(params);
        final result = await packingListsRemoteDataSource.updatePackingList(body);
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
