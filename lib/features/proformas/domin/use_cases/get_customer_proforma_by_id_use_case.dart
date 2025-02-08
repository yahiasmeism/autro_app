import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/repositories/customers_proformas_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCustomerProformaByIdUseCase extends UseCase<CustomerProformaEntity, int> {
  final CustomersProformasRepository customersProformasRepository;

  GetCustomerProformaByIdUseCase({required this.customersProformasRepository});

  @override
  Future<Either<Failure, CustomerProformaEntity>> call(int params) async {
    return await customersProformasRepository.getCustomerProformaById(params);
  }
}
