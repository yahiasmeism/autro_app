import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_customer_proforma_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/customers_proformas_repository.dart';

@lazySingleton
class UpdateCustomerProformaUseCase extends UseCase<CustomerProformaEntity, UpdateCustomerProformaUseCaseParams> {
  final CustomersProformasRepository proformasRepository;

  UpdateCustomerProformaUseCase({required this.proformasRepository});
  @override
  Future<Either<Failure, CustomerProformaEntity>> call(UpdateCustomerProformaUseCaseParams params) async {
    return await proformasRepository.updateCustomerProforma(params);
  }
}

class UpdateCustomerProformaUseCaseParams extends CreateCustomerProformaUseCaseParams {
  final int id;

  const UpdateCustomerProformaUseCaseParams({
    required this.id,
    required super.proformaNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.ports,
    required super.deliveryTerms,
    required super.paymentTerms,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
  });
}
