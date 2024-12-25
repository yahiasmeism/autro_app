import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/customers_repository.dart';

@lazySingleton
class UpdateCustomerUsecase extends UseCase<CustomerEntity, UpdateCustomerUsecaseParams> {
  final CustomersRepository customersRepository;

  UpdateCustomerUsecase({required this.customersRepository});
  @override
  Future<Either<Failure, CustomerEntity>> call(UpdateCustomerUsecaseParams params) async {
    return customersRepository.updateCustomer(params);
  }
}

class UpdateCustomerUsecaseParams extends Equatable {
  final CustomerEntity customerEntity;
  const UpdateCustomerUsecaseParams(this.customerEntity);

  @override
  List<Object?> get props => [customerEntity];
}
