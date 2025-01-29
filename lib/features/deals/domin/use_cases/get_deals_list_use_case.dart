import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../entities/deal_entity.dart';
import '../repositories/deals_repository.dart';
@lazySingleton
class GetDealsListUseCase extends UseCase<List<DealEntity>, GetDealsListUseCaseParams> {
  final DealsRepository repository;

  GetDealsListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<DealEntity>>> call(GetDealsListUseCaseParams params) async{
    return await repository.getDealsList(params);
  }
}

class GetDealsListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetDealsListUseCaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
