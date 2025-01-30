import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/use_cases/get_customers_invoices_list_use_case.dart';
import 'package:dartz/dartz.dart';

import '../use_cases/create_customer_invoice_use_case.dart';
import '../use_cases/update_customer_invoice_use_case.dart';

abstract class CustomerInvoicesRepository {
  Future<Either<Failure, CustomerInvoiceEntity>> createInvoice(CreateCustomerInvoiceUseCaseParams params);
  Future<Either<Failure, List<CustomerInvoiceEntity>>> getInvoicesList(GetCustomersInvoicesListUseCaseParams params);
  Future<Either<Failure, CustomerInvoiceEntity>> updateInvoice(UpdateCustomerInvoiceUseCaseParams params);
  Future<Either<Failure, CustomerInvoiceEntity>> getInvoiceById(int invoiceId);
  Future<Either<Failure, Unit>> deleteInvoice(int invoiceId);

  int get totalCount;
}
