import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/create_packing_list_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../reposetories/packing_lists_repository.dart';

@lazySingleton
class UpdatePackingListUseCase extends UseCase<PackingListEntity, UpdatePackingListUseCaseParams> {
  final PackingListsRepository packingListsRepository;

  UpdatePackingListUseCase({required this.packingListsRepository});
  @override
  Future<Either<Failure, PackingListEntity>> call(UpdatePackingListUseCaseParams params) async {
    return await packingListsRepository.updatePackingList(params);
  }
}

class UpdatePackingListUseCaseParams extends CreatePackingListUseCaseParams {
  final int id;

  const UpdatePackingListUseCaseParams({
    required super.details,
    required super.taxId,
    required super.number,
    required super.dealId,
    required super.descriptions,
    required this.id,
  });
}
