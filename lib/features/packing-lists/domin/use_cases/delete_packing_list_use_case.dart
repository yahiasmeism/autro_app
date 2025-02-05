import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';

import '../reposetories/packing_lists_repository.dart';

class DeletePackingListUseCase extends UseCase<Unit, int> {
  final PackingListsRepository packingListsRepository;

  DeletePackingListUseCase({required this.packingListsRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await packingListsRepository.deletePackingList(params);
  }
}
