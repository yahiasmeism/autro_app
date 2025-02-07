import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../dtos/packing_list_description_dto.dart';
import '../reposetories/packing_lists_repository.dart';

@lazySingleton
class CreatePackingListUseCase extends UseCase<PackingListEntity, CreatePackingListUseCaseParams> {
  final PackingListsRepository packingListsRepository;

  CreatePackingListUseCase({required this.packingListsRepository});
  @override
  Future<Either<Failure, PackingListEntity>> call(CreatePackingListUseCaseParams params) async {
    return await packingListsRepository.createPackingList(params);
  }
}

class CreatePackingListUseCaseParams extends Equatable {
  final String details;
  final String number;
  final int dealId;
  final List<PackingListDescriptionDto> descriptions;

  const CreatePackingListUseCaseParams({
    required this.details,
    required this.number,
    required this.dealId,
    required this.descriptions,
  });

  @override
  List<Object?> get props => [
        details,
        number,
        dealId,
        descriptions,
      ];
}
