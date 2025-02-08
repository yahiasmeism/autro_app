import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/repositories/customer_invoices_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class GetCustomerInvoiceUseCase extends UseCase<CustomerInvoiceEntity, int> {
  final CustomerInvoicesRepository repository;

  GetCustomerInvoiceUseCase({required this.repository});
  @override
  Future<Either<Failure, CustomerInvoiceEntity>> call(int params) {
    return repository.getInvoiceById(params);
  }
}
