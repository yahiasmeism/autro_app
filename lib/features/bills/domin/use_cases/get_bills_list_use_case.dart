import 'package:autro_app/core/common/domin/dto/pagination_query_payload_dto.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../entities/bill_entity.dart';
import '../repostiries/bills_respository.dart';

class GetBillsListUseCase extends UseCase<List<BillEntity>, GetBillsListUseCaseParams> {
  final BillsRepository repository;

  GetBillsListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BillEntity>>> call(GetBillsListUseCaseParams params) async{
    return await repository.getBillsList(params);
  }
}

class GetBillsListUseCaseParams extends Equatable {
  final PaginationFilterDTO paginationFilterDTO;

  const GetBillsListUseCaseParams({required this.paginationFilterDTO});

  @override
  List<Object?> get props => [paginationFilterDTO];
}
