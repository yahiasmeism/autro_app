import 'package:autro_app/features/proformas/domin/use_cases/update_supplier_proforma_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/supplier_proforma_entity.dart';
import '../use_cases/create_supplier_proforma_use_case.dart';
import '../use_cases/get_supplier_proforma_list_use_case.dart';

abstract class SupplierProformasRepository {
  Future<Either<Failure, SupplierProformaEntity>> createProforma(CreateSupplierProformaUseCaseParams params);
  Future<Either<Failure, List<SupplierProformaEntity>>> getProformasList(GetSupplierProformasListUseCaseParams params);
  Future<Either<Failure, SupplierProformaEntity>> updateProforma(UpdateSupplierProformaUseCaseParams params);
  Future<Either<Failure, SupplierProformaEntity>> getProformaById(int proformaId);
  Future<Either<Failure, Unit>> deleteProforma(int proformaId);

  int get totalCount;
}
