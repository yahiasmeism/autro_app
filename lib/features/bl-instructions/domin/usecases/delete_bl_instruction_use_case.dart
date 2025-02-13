import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/bl_instructions_repo.dart';

@lazySingleton
class DeleteBlInsturctionUseCase extends UseCase<Unit, int> {
  final BlInsturctionsRepository repository;

  DeleteBlInsturctionUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await repository.deleteBlInsturction(params);
  }
}
