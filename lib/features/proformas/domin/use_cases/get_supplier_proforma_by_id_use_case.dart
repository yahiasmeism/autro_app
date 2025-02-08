import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/repositories/supplier_invoices_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSupplierProformaByIdUseCase extends UseCase<SupplierProformaEntity, int> {
  final SupplierProformasRepository supplierProformasRepository;

  GetSupplierProformaByIdUseCase({required this.supplierProformasRepository});
  @override
  Future<Either<Failure, SupplierProformaEntity>> call(int params) async {
    return await supplierProformasRepository.getProformaById(params);
  }
}
