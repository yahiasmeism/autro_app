import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/domin/repositoreis/suppliers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/common/domin/dto/pagination_query_payload_dto.dart';

@lazySingleton
class GetSuppliersListUsecase extends UseCase<List<SupplierEntity>, GetSuppliersListUsecaseParams> {
  final SuppliersRepository supplierRepository;

  GetSuppliersListUsecase({required this.supplierRepository});
  @override
  Future<Either<Failure, List<SupplierEntity>>> call(GetSuppliersListUsecaseParams params) async {
    return await supplierRepository.getSuppliersList(params);
  }
}

class GetSuppliersListUsecaseParams extends Equatable {
  final PaginationFilterDTO dto;

  const GetSuppliersListUsecaseParams({required this.dto});

  @override
  List<Object?> get props => [dto];
}
