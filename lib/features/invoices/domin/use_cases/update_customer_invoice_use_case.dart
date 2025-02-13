import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/use_cases/create_customer_invoice_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/customer_invoices_repository.dart';

@lazySingleton
class UpdateCustomerInvoiceUseCase extends UseCase<CustomerInvoiceEntity, UpdateCustomerInvoiceUseCaseParams> {
  final CustomerInvoicesRepository invoicesRepository;

  UpdateCustomerInvoiceUseCase({required this.invoicesRepository});
  @override
  Future<Either<Failure, CustomerInvoiceEntity>> call(UpdateCustomerInvoiceUseCaseParams params) async {
    return await invoicesRepository.updateInvoice(params);
  }
}

class UpdateCustomerInvoiceUseCaseParams extends CreateCustomerInvoiceUseCaseParams {
  final int id;
  const UpdateCustomerInvoiceUseCaseParams({
    required this.id,
    required super.invoiceNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
    required super.dealId,
    required super.status,
  });
}
