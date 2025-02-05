import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_supplier_proforma_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/supplier_invoices_repository.dart';

@lazySingleton
class UpdateSupplierProformaUseCase extends UseCase<SupplierProformaEntity, UpdateSupplierProformaUseCaseParams> {
  final SupplierProformasRepository proformasRepository;

  UpdateSupplierProformaUseCase({required this.proformasRepository});
  @override
  Future<Either<Failure, SupplierProformaEntity>> call(UpdateSupplierProformaUseCaseParams params) async {
    return await proformasRepository.updateProforma(params);
  }
}

class UpdateSupplierProformaUseCaseParams extends CreateSupplierProformaUseCaseParams {
  final int id;
  final bool deleteAttachment;

  const UpdateSupplierProformaUseCaseParams({
    required super.dealId,
    required super.supplierId,
    required super.material,
    required super.totalAmount,
    required super.date,
    required super.attachementPath,
    required this.id,
    required this.deleteAttachment,
  });
}
