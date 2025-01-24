import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/invoices/domin/entities/invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/use_cases/get_invoices_list_use_case.dart';
import 'package:dartz/dartz.dart';

import '../use_cases/create_invoice_use_case.dart';
import '../use_cases/update_invoice_use_case.dart';

abstract class InvoicesRepository {
  Future<Either<Failure, InvoiceEntity>> createInvoice(CreateInvoiceUseCaseParams params);
  Future<Either<Failure, List<InvoiceEntity>>> getInvoicesList(GetInvoicesListUseCaseParams params);
  Future<Either<Failure, InvoiceEntity>> updateInvoice(UpdateInvoiceUseCaseParams params);
  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int invoiceId);
  Future<Either<Failure, Unit>> deleteInvoice(int invoiceId);

  int get totalCount;
}
