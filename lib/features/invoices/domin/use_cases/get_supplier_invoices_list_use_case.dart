import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/repositories/supplier_invoices_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';

@lazySingleton
class GetSuppliersInvoicesListUseCase extends UseCase<List<SupplierInvoiceEntity>, GetSupplierInvoicesListUseCaseParams> {
  final SupplierInvoicesRepository repository;

  GetSuppliersInvoicesListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<SupplierInvoiceEntity>>> call(GetSupplierInvoicesListUseCaseParams params) async {
    return await repository.getInvoicesList(params);
  }
}

class GetSupplierInvoicesListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetSupplierInvoicesListUseCaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
