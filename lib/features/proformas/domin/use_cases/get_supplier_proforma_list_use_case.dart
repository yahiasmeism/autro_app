import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../repositories/supplier_invoices_repository.dart';

@lazySingleton
class GetSuppliersProformasListUseCase extends UseCase<List<SupplierProformaEntity>, GetSupplierProformasListUseCaseParams> {
  final SupplierProformasRepository repository;

  GetSuppliersProformasListUseCase({required this.repository});
  @override
  Future<Either<Failure, List<SupplierProformaEntity>>> call(GetSupplierProformasListUseCaseParams params) async {
    return await repository.getProformasList(params);
  }
}

class GetSupplierProformasListUseCaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetSupplierProformasListUseCaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
