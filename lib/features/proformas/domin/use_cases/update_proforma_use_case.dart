import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_proforma_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/proformas_repository.dart';

@lazySingleton
class UpdateProformaUseCase extends UseCase<ProformaEntity, UpdateProformaUseCaseParams> {
  final ProformasRepository proformasRepository;

  UpdateProformaUseCase({required this.proformasRepository});
  @override
  Future<Either<Failure, ProformaEntity>> call(UpdateProformaUseCaseParams params) async {
    return await proformasRepository.updateProforma(params);
  }
}

class UpdateProformaUseCaseParams extends CreateProformaUseCaseParams {
  final int id;

  const UpdateProformaUseCaseParams({
    required this.id,
    required super.proformaNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.ports,
    required super.deliveryTerms,
    required super.paymentTerms,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
  });
}
