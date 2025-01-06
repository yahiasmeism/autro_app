import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/domin/repositoreis/suppliers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateSupplierUsecase extends UseCase<SupplierEntity, UpdateSupplierUsecaseParams> {
  final SuppliersRepository suppliersRepository;

  UpdateSupplierUsecase({required this.suppliersRepository});
  @override
  Future<Either<Failure, SupplierEntity>> call(UpdateSupplierUsecaseParams params) async {
    return await suppliersRepository.updateSupplier(params);
  }
}

class UpdateSupplierUsecaseParams extends Equatable {
  final SupplierEntity supplierEntity;
  const UpdateSupplierUsecaseParams(this.supplierEntity);

  @override
  List<Object?> get props => [supplierEntity];
}
