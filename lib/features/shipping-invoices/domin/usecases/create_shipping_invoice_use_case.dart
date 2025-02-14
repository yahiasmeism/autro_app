import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/shipping_invoices_repository.dart';

@lazySingleton
class CreateShippingInvoiceUseCase extends UseCase<ShippingInvoiceEntity, CreateShippingInvoiceUseCaseParams> {
  final ShippingInvoicesRepository repository;

  CreateShippingInvoiceUseCase({required this.repository});
  @override
  Future<Either<Failure, ShippingInvoiceEntity>> call(CreateShippingInvoiceUseCaseParams params) async {
    return await repository.createShippingInvoice(params);
  }
}

class CreateShippingInvoiceUseCaseParams extends Equatable {
  final int dealId;
  final String shippingCompanyName;
  final double shippingCost;
  final String typeMaterialName;
  final DateTime shippingDate;
  final String status;
  final String? attachmentPath;
  final bool deleteAttachment;
  const CreateShippingInvoiceUseCaseParams({
    this.deleteAttachment = false,
    required this.dealId,
    required this.status,
    required this.shippingCompanyName,
    required this.shippingCost,
    required this.typeMaterialName,
    required this.shippingDate,
    this.attachmentPath,
  });
  @override
  List<Object?> get props => [
        dealId,
        shippingCompanyName,
        shippingCost,
        typeMaterialName,
        shippingDate,
        attachmentPath,
        status,
      ];
}
