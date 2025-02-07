import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../reposetories/packing_lists_repository.dart';
@lazySingleton
class DeletePackingListUseCase extends UseCase<Unit, int> {
  final PackingListsRepository packingListsRepository;

  DeletePackingListUseCase({required this.packingListsRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await packingListsRepository.deletePackingList(params);
  }
}
