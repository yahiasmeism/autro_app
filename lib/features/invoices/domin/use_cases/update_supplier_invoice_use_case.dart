import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/use_cases/create_supplier_invoice_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/supplier_invoices_repository.dart';

@lazySingleton
class UpdateSupplierInvoiceUseCase extends UseCase<SupplierInvoiceEntity, UpdateSupplierInvoiceUseCaseParams> {
  final SupplierInvoicesRepository invoicesRepository;

  UpdateSupplierInvoiceUseCase({required this.invoicesRepository});
  @override
  Future<Either<Failure, SupplierInvoiceEntity>> call(UpdateSupplierInvoiceUseCaseParams params) async {
    return await invoicesRepository.updateInvoice(params);
  }
}

class UpdateSupplierInvoiceUseCaseParams extends CreateSupplierInvoiceUseCaseParams {
  final int id;
  final bool deleteAttachment;

  const UpdateSupplierInvoiceUseCaseParams({
    required super.dealId,
    required super.supplierId,
    required super.material,
    required super.totalAmount,
    required super.date,
    required super.attachementPath,
    required super.status,
    required this.id,
    required this.deleteAttachment,
  });

  @override
  List<Object?> get props => [...super.props, id, deleteAttachment];
}
