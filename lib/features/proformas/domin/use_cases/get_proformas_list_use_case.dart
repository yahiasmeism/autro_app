import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../entities/proforma_entity.dart';
import '../repositories/proformas_repository.dart';
@lazySingleton
class GetProformasListUseCase extends UseCase<List<ProformaEntity>, GetProformasListUseCaseParams> {
  final ProformasRepository repository;

  GetProformasListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<ProformaEntity>>> call(GetProformasListUseCaseParams params) async{
    return await repository.getProformasList(params);
  }
}

class GetProformasListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetProformasListUseCaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
