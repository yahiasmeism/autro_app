import 'package:autro_app/core/common/domin/dto/pagination_query_payload_dto.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../entities/shipping_invoice_entites.dart';
import '../repositories/shipping_invoice_repository.dart';
@lazySingleton
class GetShippingInvoicesListUseCase extends UseCase<List<ShippingInvoiceEntity>, GetShippingInvoicesListUseCaseParams> {
  final ShippingInvoiceRepository repository;

  GetShippingInvoicesListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ShippingInvoiceEntity>>> call(GetShippingInvoicesListUseCaseParams params) async{
    return await repository.getShippingInvoicesList(params);
  }
}

class GetShippingInvoicesListUseCaseParams extends Equatable {
  final PaginationFilterDTO paginationFilterDTO;

  const GetShippingInvoicesListUseCaseParams({required this.paginationFilterDTO});

  @override
  List<Object?> get props => [paginationFilterDTO];
}
