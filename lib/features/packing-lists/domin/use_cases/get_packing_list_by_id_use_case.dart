import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:autro_app/features/packing-lists/domin/reposetories/packing_lists_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPackingListByIdUseCase extends UseCase<PackingListEntity, int> {
  final PackingListsRepository repository;

  GetPackingListByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, PackingListEntity>> call(int params) async {
    return await repository.getPackingList(params);
  }
}
