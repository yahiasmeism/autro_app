import 'package:autro_app/core/common/domin/dto/pagination_query_payload_dto.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/bl_insturction_entity.dart';
import '../repositories/bl_instructions_repo.dart';

@lazySingleton
class GetBlInsturctionsListUseCase extends UseCase<List<BlInsturctionEntity>, GetBlInsturctionsListUseCaseParams> {
  final BlInsturctionsRepository repository;

  GetBlInsturctionsListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BlInsturctionEntity>>> call(GetBlInsturctionsListUseCaseParams params) async {
    return await repository.getBlInsturctionsList(params);
  }
}

class GetBlInsturctionsListUseCaseParams extends Equatable {
  final PaginationFilterDTO paginationFilterDTO;

  const GetBlInsturctionsListUseCaseParams({required this.paginationFilterDTO});

  @override
  List<Object?> get props => [paginationFilterDTO];
}
