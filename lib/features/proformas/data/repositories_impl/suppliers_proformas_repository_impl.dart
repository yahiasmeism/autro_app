import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/failures.dart';

import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';

import 'package:autro_app/features/proformas/domin/use_cases/create_supplier_proforma_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/data/requests/pagination_list_request.dart';
import '../../../../core/network_info/network_info.dart';

import '../../domin/repositories/supplier_invoices_repository.dart';
import '../../domin/use_cases/get_supplier_proforma_list_use_case.dart';
import '../../domin/use_cases/update_supplier_proforma_use_case.dart';
import '../data_sources/remote/suppliers_proformas_remote_data_source.dart';
import '../models/requests/create_supplier_proforma_request.dart';
import '../models/requests/get_suppliers_proforma_list_request.dart';
import '../models/requests/update_supplier_proforma_request.dart';

@LazySingleton(as: SupplierProformasRepository)
class SuppliersProformasRepositoryImpl extends SupplierProformasRepository {
  final SuppliersProformasRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  int _totalCount = 0;
  SuppliersProformasRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, SupplierProformaEntity>> createProforma(CreateSupplierProformaUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = CreateSupplierProformaRequest.fromParams(params);
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
  Future<Either<Failure, SupplierProformaEntity>> getProformaById(int proformaId) async {
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
  Future<Either<Failure, List<SupplierProformaEntity>>> getProformasList(GetSupplierProformasListUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final paginationFilterBody = PaginationFilterRequest.fromDTO(params.dto);
        final body = GetSuppliersProformasListRequest(paginationFilterRequest: paginationFilterBody);
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
  Future<Either<Failure, SupplierProformaEntity>> updateProforma(UpdateSupplierProformaUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final body = UpdateSupplierProformaRequest.fromParams(params);
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
