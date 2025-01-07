import 'package:autro_app/core/common/data/requests/pagination_list_request.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';

import 'package:autro_app/features/suppliers/data/models/requests/create_supplier_request.dart';
import 'package:autro_app/features/suppliers/data/models/requests/get_suppliers_list_request.dart';
import 'package:autro_app/features/suppliers/data/models/requests/update_supplier_request.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/domin/usecases/get_suppliers_list_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domin/repositoreis/suppliers_repository.dart';
import '../../domin/usecases/create_supplier_usecase.dart';
import '../../domin/usecases/update_supplier_usecase.dart';
import '../datasources/suppliers_remote_datesourse.dart';

@LazySingleton(as: SuppliersRepository)
class SuppliersRepositoryImpl implements SuppliersRepository {
  late int _totalCount;
  final SuppliersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SuppliersRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<SupplierEntity>>> getSuppliersList(GetSuppliersListUsecaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
        final body = GetSuppliersListRequest(paginationFilterRequest: paginationFilterBody);
        final paginationList = await remoteDataSource.getSuppleirsList(body);
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
  Future<Either<Failure, SupplierEntity>> createSupplier(CreateSupplierUsecaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateSupplierRequest.fromParams(params);
        final supplier = await remoteDataSource.createSupplier(body);
        return Right(supplier);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSupplier(int supplierId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteSupplier(supplierId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> getSupplier(int supplierId) async {
    if (await networkInfo.isConnected) {
      try {
        final supplier = await remoteDataSource.getSupplier(supplierId);
        return Right(supplier);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> updateSupplier(UpdateSupplierUsecaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateSupplierRequest.fromParams(params);
        final supplier = await remoteDataSource.updateSupplier(body);
        return Right(supplier);
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
