import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/bl_insturction_entity.dart';
import '../repositories/bl_instructions_repo.dart';

@lazySingleton
class CreateBlInsturctionUseCase extends UseCase<BlInsturctionEntity, CreateBlInsturctionUseCaseParams> {
  final BlInsturctionsRepository repository;

  CreateBlInsturctionUseCase({required this.repository});
  @override
  Future<Either<Failure, BlInsturctionEntity>> call(CreateBlInsturctionUseCaseParams params) async {
    return await repository.createBlInsturction(params);
  }
}

class CreateBlInsturctionUseCaseParams extends Equatable {
  final int dealId;
  final String number;
  final DateTime date;
  final String? attachmentPath;
  final bool deleteAttachment;

  const CreateBlInsturctionUseCaseParams({
    required this.dealId,
    required this.number,
    required this.date,
    required this.attachmentPath,
    required this.deleteAttachment,
  });

  @override
  List<Object?> get props => [
        dealId,
        number,
        date,
        attachmentPath,
        deleteAttachment,
      ];
}
