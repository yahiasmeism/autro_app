import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/proforma_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/proformas_repository.dart';

@lazySingleton
class UpdateProformaUseCase extends UseCase<ProformaEntity, ProformaEntity> {
  final ProformasRepository proformasRepository;

  UpdateProformaUseCase({required this.proformasRepository});
  @override
  Future<Either<Failure, ProformaEntity>> call(ProformaEntity params) async {
    return await proformasRepository.updateProforma(params);
  }
}
