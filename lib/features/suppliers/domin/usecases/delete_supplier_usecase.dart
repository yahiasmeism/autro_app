import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/suppliers/domin/repositoreis/suppliers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteSupplierUsecase extends UseCase<Unit, int> {
  final SuppliersRepository suppliersRepository;

  DeleteSupplierUsecase({required this.suppliersRepository});

  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await suppliersRepository.deleteSupplier(params);
  }
}
