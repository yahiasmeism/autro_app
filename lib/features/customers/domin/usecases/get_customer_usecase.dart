import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/customers_repository.dart';

@lazySingleton
class GetCustomerUsecase extends UseCase<CustomerEntity, int> {
  final CustomersRepository customersRepository;

  GetCustomerUsecase({required this.customersRepository});
  @override
  Future<Either<Failure, CustomerEntity>> call(int params) async {
    return await customersRepository.getCustomer(params);
  }
}
