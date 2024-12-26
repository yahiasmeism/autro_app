import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/customers_repository.dart';
@lazySingleton
class DeleteCustomerUsecase extends UseCase<Unit, int> {
  final CustomersRepository customersRepository;

  DeleteCustomerUsecase({required this.customersRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await customersRepository.deleteCustomer(params);
  }
}
