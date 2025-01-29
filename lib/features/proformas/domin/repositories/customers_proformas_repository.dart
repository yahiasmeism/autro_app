import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/use_cases/get_customers_proformas_list_use_case.dart';
import 'package:dartz/dartz.dart';

import '../use_cases/create_customer_proforma_use_case.dart';
import '../use_cases/update_customer_proforma_use_case.dart';

abstract class CustomersProformasRepository {
  Future<Either<Failure, CustomerProformaEntity>> createCustomerProforma(CreateCustomerProformaUseCaseParams params);
  Future<Either<Failure, List<CustomerProformaEntity>>> getCustomersProformasList(GetCustomersProformasListUseCaseParams params);
  Future<Either<Failure, CustomerProformaEntity>> updateCustomerProforma(UpdateCustomerProformaUseCaseParams params);
  Future<Either<Failure, CustomerProformaEntity>> getCustomerProformaById(int proformaId);
  Future<Either<Failure, Unit>> deleteCustomerProforma(int proformaId);

  int get totalCount;
}
