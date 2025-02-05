import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/supplier_invoices_repository.dart';

@lazySingleton
class CreateSupplierProformaUseCase extends UseCase<SupplierProformaEntity, CreateSupplierProformaUseCaseParams> {
  final SupplierProformasRepository repository;

  CreateSupplierProformaUseCase({required this.repository});
  @override
  Future<Either<Failure, SupplierProformaEntity>> call(CreateSupplierProformaUseCaseParams params) async {
    return await repository.createProforma(params);
  }
}

class CreateSupplierProformaUseCaseParams extends Equatable {
  final int dealId;
  final int supplierId;
  final String material;
  final double totalAmount;
  final DateTime date;
  final String? attachementPath;

  const CreateSupplierProformaUseCaseParams({
    required this.dealId,
    required this.supplierId,
    required this.material,
    required this.totalAmount,
    required this.date,
    required this.attachementPath,
  });

  @override
  List<Object?> get props => [
        dealId,
        supplierId,
        material,
        totalAmount,
        date,
        attachementPath,
      ];
}
