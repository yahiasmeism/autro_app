import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../repositories/proformas_repository.dart';

@lazySingleton
class DeleteProformaUseCase extends UseCase<Unit, int> {
  final ProformasRepository proformasRepository;

  DeleteProformaUseCase({required this.proformasRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await proformasRepository.deleteProforma(params);
  }
}
