import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/bl_insturction_entity.dart';
import '../usecases/create_bl_instruction_use_case.dart';
import '../usecases/get_bl_instruction_list_use_case.dart';
import '../usecases/update_bl_instruction_use_case.dart';

abstract class BlInsturctionsRepository {
  Future<Either<Failure, List<BlInsturctionEntity>>> getBlInsturctionsList(GetBlInsturctionsListUseCaseParams params);

  Future<Either<Failure, BlInsturctionEntity>> getBlInsturctionById(int id);

  Future<Either<Failure, BlInsturctionEntity>> createBlInsturction(CreateBlInsturctionUseCaseParams params);

  Future<Either<Failure, BlInsturctionEntity>> updateBlInsturction(UpdateBlInsturctionUseCaseParams params);

  Future<Either<Failure, Unit>> deleteBlInsturction(int id);

  int get blInsturctionsCount;
}
