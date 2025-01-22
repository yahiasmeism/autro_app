import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/proformas/data/data_sources/remote/proformas_remote_data_source.dart';

import 'package:autro_app/features/proformas/domin/entities/proforma_entity.dart';

import 'package:autro_app/features/proformas/domin/use_cases/create_proforma_use_case.dart';

import 'package:autro_app/features/proformas/domin/use_cases/get_proformas_list_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/data/requests/pagination_list_request.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domin/repositories/proformas_repository.dart';
import '../../domin/use_cases/update_proforma_use_case.dart';
import '../models/requests/create_proforma_request.dart';
import '../models/requests/get_proformas_list_request.dart';
import '../models/requests/update_proforma_request.dart';

@LazySingleton(as: ProformasRepository)
class ProformasRepositoryImpl extends ProformasRepository {
  final ProformasRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _totalCount = 0;
  ProformasRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, ProformaEntity>> createProforma(CreateProformaUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateProformaRequest.fromParams(params);
        final proforma = await remoteDataSource.createProforma(body);
        return Right(proforma);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProforma(int proformaId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProforma(proformaId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, ProformaEntity>> getProformaById(int proformaId) async {
    if (await networkInfo.isConnected) {
      try {
        final proforma = await remoteDataSource.getProformaById(proformaId);
        return Right(proforma);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<ProformaEntity>>> getProformasList(GetProformasListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
        final body = GetProformasListRequest(paginationFilterRequest: paginationFilterBody);
        final paginationList = await remoteDataSource.getProformasList(body);
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
  Future<Either<Failure, ProformaEntity>> updateProforma(UpdateProformaUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateProformaRequest.fromParams(params);
        final updatedProforma = await remoteDataSource.updateProforma(body);
        return Right(updatedProforma);
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
