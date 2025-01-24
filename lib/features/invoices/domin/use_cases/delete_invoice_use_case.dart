import 'package:autro_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../../../invoices/domin/repositories/invoices_repository.dart';

@lazySingleton
class DeleteInvoiceUseCase extends UseCase<Unit, int> {
  final InvoicesRepository invoicesRepository;

  DeleteInvoiceUseCase({required this.invoicesRepository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await invoicesRepository.deleteInvoice(params);
  }
}
