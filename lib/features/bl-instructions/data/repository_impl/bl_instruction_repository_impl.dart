import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domin/entities/bl_insturction_entity.dart';
import '../../domin/repositories/bl_instructions_repo.dart';
import '../../domin/usecases/create_bl_instruction_use_case.dart';
import '../../domin/usecases/get_bl_instruction_list_use_case.dart';
import '../../domin/usecases/update_bl_instruction_use_case.dart';
import '../data_sources/remote/bl_instructions_remote_date_source.dart';
import '../models/requests/create_bl_instruction_request.dart';
import '../models/requests/get_bl_instructions_list_request.dart';
import '../models/requests/update_bl_instruction_request.dart';

@LazySingleton(as: BlInsturctionsRepository)
class BlInsturctionsRepositoryImpl extends BlInsturctionsRepository {
  final NetworkInfo networkInfo;
  final BlInsturctionsRemoteDateSource remoteDataSource;
  int _totalCount = 0;
  BlInsturctionsRepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, BlInsturctionEntity>> createBlInsturction(CreateBlInsturctionUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateBlInsturctionRequest.fromParams(params);
        final shippingInvoice = await remoteDataSource.createBlInsturction(body);
        return Right(shippingInvoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBlInsturction(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteBlInsturction(id);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, BlInsturctionEntity>> getBlInsturctionById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final shippingInvoice = await remoteDataSource.getBlInsturction(id);
        return Right(shippingInvoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<BlInsturctionEntity>>> getBlInsturctionsList(GetBlInsturctionsListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = GetBlInstructionsListRequest(paginationFilterDTO: params.paginationFilterDTO);
        final shippingInvoices = await remoteDataSource.getBlInsturctionsList(body);
        _totalCount = shippingInvoices.total;
        return Right(shippingInvoices.data);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  int get blInsturctionsCount => _totalCount;

  @override
  Future<Either<Failure, BlInsturctionEntity>> updateBlInsturction(UpdateBlInsturctionUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateBlInsturctionRequest.fromParams(params);
        final shippingInvoice = await remoteDataSource.updateBlInsturction(body);
        return Right(shippingInvoice);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
