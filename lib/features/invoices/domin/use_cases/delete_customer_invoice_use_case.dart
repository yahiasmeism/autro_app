import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../repositories/customer_invoices_repository.dart';

@lazySingleton
class DeleteCustomerInvoiceUseCase extends UseCase<Unit, int> {
  final CustomerInvoicesRepository invoicesRepository;

  DeleteCustomerInvoiceUseCase({required this.invoicesRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await invoicesRepository.deleteInvoice(params);
  }
}
