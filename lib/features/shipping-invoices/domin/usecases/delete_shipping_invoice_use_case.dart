import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/shipping_invoices_repository.dart';

@lazySingleton
class DeleteShippingInvoiceUseCase extends UseCase<Unit, int> {
  final ShippingInvoicesRepository repository;

  DeleteShippingInvoiceUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await repository.deleteShippingInvoice(params);
  }
}
