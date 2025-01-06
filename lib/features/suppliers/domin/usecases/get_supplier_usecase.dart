import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositoreis/suppliers_repository.dart';

@lazySingleton
class GetSupplierUsecase extends UseCase<SupplierEntity, int> {
  final SuppliersRepository suppliersRepository;

  GetSupplierUsecase({required this.suppliersRepository});
  @override
  Future<Either<Failure, SupplierEntity>> call(int params) async {
    return await suppliersRepository.getSupplier(params);
  }
}
