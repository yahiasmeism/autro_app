import 'package:autro_app/features/invoices/domin/use_cases/update_supplier_invoice_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/supplier_invoice_entity.dart';
import '../use_cases/create_supplier_invoice_use_case.dart';
import '../use_cases/get_supplier_invoices_list_use_case.dart';

abstract class SupplierInvoicesRepository {
  Future<Either<Failure, SupplierInvoiceEntity>> createInvoice(CreateSupplierInvoiceUseCaseParams params);
  Future<Either<Failure, List<SupplierInvoiceEntity>>> getInvoicesList(GetSupplierInvoicesListUseCaseParams params);
  Future<Either<Failure, SupplierInvoiceEntity>> updateInvoice(UpdateSupplierInvoiceUseCaseParams params);
  Future<Either<Failure, SupplierInvoiceEntity>> getInvoiceById(int invoiceId);
  Future<Either<Failure, Unit>> deleteInvoice(int invoiceId);

  int get totalCount;
}
