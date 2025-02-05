import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../repositories/supplier_invoices_repository.dart';

@lazySingleton
class DeleteSupplierProformaUseCase extends UseCase<Unit, int> {
  final SupplierProformasRepository proformasRepository;

  DeleteSupplierProformaUseCase({required this.proformasRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await proformasRepository.deleteProforma(params);
  }
}
