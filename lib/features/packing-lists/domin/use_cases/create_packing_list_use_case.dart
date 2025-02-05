import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../reposetories/packing_lists_repository.dart';

class CreatePackingListUseCase extends UseCase<PackingListEntity, CreatePackingListUseCaseParams> {
  final PackingListsRepository packingListsRepository;

  CreatePackingListUseCase({required this.packingListsRepository});
  @override
  Future<Either<Failure, PackingListEntity>> call(CreatePackingListUseCaseParams params) async {
    return await packingListsRepository.createPackingList(params);
  }
}

class CreatePackingListUseCaseParams extends Equatable {
  final String containerNumber;
  final double weight;
  final double vgm;
  final DateTime date;
  final double percent;

  const CreatePackingListUseCaseParams(
      {required this.containerNumber, required this.weight, required this.vgm, required this.date, required this.percent});

  @override
  List<Object?> get props => [
        containerNumber,
        weight,
        vgm,
        date,
        percent,
      ];
}
