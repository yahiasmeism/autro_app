import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../entities/invoice_entity.dart';
import '../repositories/invoices_repository.dart';

@lazySingleton
class GetInvoicesListUseCase extends UseCase<List<InvoiceEntity>, GetInvoicesListUseCaseParams> {
  final InvoicesRepository repository;

  GetInvoicesListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<InvoiceEntity>>> call(GetInvoicesListUseCaseParams params) async {
    return await repository.getInvoicesList(params);
  }
}

class GetInvoicesListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetInvoicesListUseCaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
