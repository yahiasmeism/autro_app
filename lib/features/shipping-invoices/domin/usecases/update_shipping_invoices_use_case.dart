import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/create_shipping_invoice_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/shipping_invoice_entites.dart';
import '../repositories/shipping_invoices_repository.dart';

@lazySingleton
class UpdateShippingInvoicesUseCase extends UseCase<ShippingInvoiceEntity, UpdateShippingInvoiceUseCaseParams> {
  final ShippingInvoicesRepository shippingInvoiceRepository;

  UpdateShippingInvoicesUseCase({required this.shippingInvoiceRepository});
  @override
  Future<Either<Failure, ShippingInvoiceEntity>> call(UpdateShippingInvoiceUseCaseParams params) async {
    return await shippingInvoiceRepository.updateShippingInvoice(params);
  }
}

class UpdateShippingInvoiceUseCaseParams extends CreateShippingInvoiceUseCaseParams {
  final int id;
  const UpdateShippingInvoiceUseCaseParams({
    required this.id,
    required super.invoiceId,
    required super.shippingCompanyName,
    required super.shippingCost,
    required super.typeMaterialName,
    required super.currency,
    required super.shippingDate,
    super.attachmentPath,
  });

  @override
  List<Object?> get props => [
        id,
        invoiceId,
        shippingCompanyName,
        shippingCost,
        typeMaterialName,
        currency,
        shippingDate,
        attachmentPath,
      ];
}
