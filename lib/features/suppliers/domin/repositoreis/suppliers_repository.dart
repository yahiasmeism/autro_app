import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:dartz/dartz.dart';

import '../usecases/create_supplier_usecase.dart';
import '../usecases/get_suppliers_list_usecase.dart';
import '../usecases/update_supplier_usecase.dart';

abstract class SuppliersRepository {
  Future<Either<Failure, SupplierEntity>> createSupplier(CreateSupplierUsecaseParams params);
  Future<Either<Failure, List<SupplierEntity>>> getSuppliersList(GetSuppliersListUsecaseParams params);
  Future<Either<Failure, SupplierEntity>> updateSupplier(UpdateSupplierUsecaseParams params);
  Future<Either<Failure, SupplierEntity>> getSupplier(int supplierId);
  Future<Either<Failure, Unit>> deleteSupplier(int supplierId);

  int get totalCount;
}
