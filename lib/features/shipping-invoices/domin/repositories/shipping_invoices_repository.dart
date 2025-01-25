import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/get_shipping_invoices_list_use_case.dart';
import 'package:dartz/dartz.dart';

import '../entities/shipping_invoice_entites.dart';
import '../usecases/create_shipping_invoice_use_case.dart';
import '../usecases/update_shipping_invoices_use_case.dart';

abstract class ShippingInvoicesRepository {
  Future<Either<Failure, List<ShippingInvoiceEntity>>> getShippingInvoicesList(GetShippingInvoicesListUseCaseParams params);

  Future<Either<Failure, ShippingInvoiceEntity>> getShippingInvoiceById(int id);

  Future<Either<Failure, ShippingInvoiceEntity>> createShippingInvoice(CreateShippingInvoiceUseCaseParams params);

  Future<Either<Failure, ShippingInvoiceEntity>> updateShippingInvoice(UpdateShippingInvoiceUseCaseParams params);

  Future<Either<Failure, Unit>> deleteShippingInvoice(int id);

  int get shippingInvoicesCount;
}
