import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/bl_insturction_entity.dart';
import '../repositories/bl_instructions_repo.dart';

@lazySingleton
class GetBlInsturctionByIdUseCase extends UseCase<BlInsturctionEntity, int> {
  final BlInsturctionsRepository shippingInvoicesRepository;

  GetBlInsturctionByIdUseCase({required this.shippingInvoicesRepository});
  @override
  Future<Either<Failure, BlInsturctionEntity>> call(int params) async {
    return await shippingInvoicesRepository.getBlInsturctionById(params);
  }
}
