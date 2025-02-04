import 'package:autro_app/core/common/domin/dto/pagination_query_payload_dto.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/deals/domin/repositories/deals_bills_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/deal_bill_entity.dart';
@lazySingleton
class GetDealsBillsListUseCase extends UseCase<List<DealBillEntity>, GetDealsBillsListUseCaseParams> {
  final DealsBillsRepository dealsBillsRepository;

  GetDealsBillsListUseCase({required this.dealsBillsRepository});
  @override
  Future<Either<Failure, List<DealBillEntity>>> call(GetDealsBillsListUseCaseParams params)async {
    return await dealsBillsRepository.getDealsBillsList(params);
  }
}

class GetDealsBillsListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;
  final int dealId;

  const GetDealsBillsListUseCaseParams({required this.dto, required this.dealId});

  @override
  List<Object?> get props => [dto];
}
