import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entity.dart';
import 'package:autro_app/features/shipping-invoices/domin/repositories/shipping_invoices_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetShippingInvoiceByIdUseCase extends UseCase<ShippingInvoiceEntity, int> {
  final ShippingInvoicesRepository shippingInvoicesRepository;

  GetShippingInvoiceByIdUseCase({required this.shippingInvoicesRepository});

  @override
  Future<Either<Failure, ShippingInvoiceEntity>> call(int params) async {
    return await shippingInvoicesRepository.getShippingInvoiceById(params);
  }
}
