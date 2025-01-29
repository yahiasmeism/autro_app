import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../entities/customer_proforma_entity.dart';
import '../repositories/customers_proformas_repository.dart';

@lazySingleton
class GetCustomersProformasListUseCase extends UseCase<List<CustomerProformaEntity>, GetCustomersProformasListUseCaseParams> {
  final CustomersProformasRepository repository;

  GetCustomersProformasListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<CustomerProformaEntity>>> call(GetCustomersProformasListUseCaseParams params) async {
    return await repository.getCustomersProformasList(params);
  }
}

class GetCustomersProformasListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetCustomersProformasListUseCaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
