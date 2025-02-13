import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/bl_insturction_entity.dart';
import '../repositories/bl_instructions_repo.dart';
import 'create_bl_instruction_use_case.dart';

@lazySingleton
class UpdateBlInsturctionsUseCase extends UseCase<BlInsturctionEntity, UpdateBlInsturctionUseCaseParams> {
  final BlInsturctionsRepository shippingInvoiceRepository;

  UpdateBlInsturctionsUseCase({required this.shippingInvoiceRepository});
  @override
  Future<Either<Failure, BlInsturctionEntity>> call(UpdateBlInsturctionUseCaseParams params) async {
    return await shippingInvoiceRepository.updateBlInsturction(params);
  }
}

class UpdateBlInsturctionUseCaseParams extends CreateBlInsturctionUseCaseParams {
  final int id;

  const UpdateBlInsturctionUseCaseParams({
    required super.dealId,
    required super.number,
    required super.date,
    required super.attachmentPath,
    required super.deleteAttachment,
    required this.id,
  });

  @override
  List<Object?> get props => [id, ...super.props];
}
