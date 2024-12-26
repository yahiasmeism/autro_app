import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../repositories/customers_repository.dart';
@lazySingleton
class GetCustomersListUsecase extends UseCase<List<CustomerEntity>, GetCustomersListUsecaseParams> {
  final CustomersRepository customersRepository;

  GetCustomersListUsecase({required this.customersRepository});
  @override
  Future<Either<Failure, List<CustomerEntity>>> call(GetCustomersListUsecaseParams params) async {
    return await customersRepository.getCustomersList(params);
  }
}

class GetCustomersListUsecaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetCustomersListUsecaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
