import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/update_packing_list_use_case.dart';
import 'package:dartz/dartz.dart';

import '../use_cases/create_packing_list_use_case.dart';
import '../use_cases/get_all_packing_lists_use_case.dart';

abstract class PackingListsRepository {
  Future<Either<Failure, List<PackingListEntity>>> getPackingLists(GetAllPackingListsUseCaseParams params);
  Future<Either<Failure, PackingListEntity>> createPackingList(CreatePackingListUseCaseParams params);
  Future<Either<Failure, PackingListEntity>> updatePackingList(UpdatePackingListUseCaseParams params);
  Future<Either<Failure, Unit>> deletePackingList(int id);
  Future<Either<Failure, PackingListEntity>> getPackingList(int id);

  int get totalCount;
}
