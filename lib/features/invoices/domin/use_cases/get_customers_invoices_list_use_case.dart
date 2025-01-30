import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../entities/customer_invoice_entity.dart';
import '../repositories/customer_invoices_repository.dart';

@lazySingleton
class GetCustomersInvoicesListUseCase extends UseCase<List<CustomerInvoiceEntity>, GetCustomersInvoicesListUseCaseParams> {
  final CustomerInvoicesRepository repository;

  GetCustomersInvoicesListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<CustomerInvoiceEntity>>> call(GetCustomersInvoicesListUseCaseParams params) async {
    return await repository.getInvoicesList(params);
  }
}

class GetCustomersInvoicesListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetCustomersInvoicesListUseCaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
