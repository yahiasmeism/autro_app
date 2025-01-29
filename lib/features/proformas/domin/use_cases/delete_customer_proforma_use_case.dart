import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../repositories/customers_proformas_repository.dart';

@lazySingleton
class DeleteCustomerProformaUseCase extends UseCase<Unit, int> {
  final CustomersProformasRepository proformasRepository;

  DeleteCustomerProformaUseCase({required this.proformasRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await proformasRepository.deleteCustomerProforma(params);
  }
}
