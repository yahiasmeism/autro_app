import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/proformas/domin/entities/proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/use_cases/get_proformas_list_use_case.dart';
import 'package:dartz/dartz.dart';

import '../use_cases/create_proforma_use_case.dart';

abstract class ProformasRepository {
  Future<Either<Failure, ProformaEntity>> createProforma(CreateProformaUseCaseParams params);
  Future<Either<Failure, List<ProformaEntity>>> getProformasList(GetProformasListUseCaseParams params);
  Future<Either<Failure, ProformaEntity>> updateProforma(ProformaEntity proforma);
  Future<Either<Failure, ProformaEntity>> getProformaById(int proformaId);
  Future<Either<Failure, Unit>> deleteProforma(int proformaId);

  int get totalCount;
}
