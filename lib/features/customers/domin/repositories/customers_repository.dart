import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/domin/usecases/create_customer_usecase.dart';
import 'package:autro_app/features/customers/domin/usecases/get_customers_list_usecase.dart';
import 'package:autro_app/features/customers/domin/usecases/update_customer_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class CustomersRepository {
  Future<Either<Failure, CustomerEntity>> createCustomer(CreateCustomerUsecaseParams params);
  Future<Either<Failure, List<CustomerEntity>>> getCustomersList(GetCustomersListUsecaseParams params);
  Future<Either<Failure, CustomerEntity>> updateCustomer(UpdateCustomerUsecaseParams params);
  Future<Either<Failure, CustomerEntity>> getCustomer(int customerId);
  Future<Either<Failure, Unit>> deleteCustomer(int customerId);

  int get totalCount;
}
