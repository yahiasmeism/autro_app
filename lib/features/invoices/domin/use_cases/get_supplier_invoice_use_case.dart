import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/repositories/supplier_invoices_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSupplierInvoiceUseCase extends UseCase<SupplierInvoiceEntity, int> {
  final SupplierInvoicesRepository supplierInvoicesRepository;

  GetSupplierInvoiceUseCase({required this.supplierInvoicesRepository});
  @override
  Future<Either<Failure, SupplierInvoiceEntity>> call(int params) async {
    return await supplierInvoicesRepository.getInvoiceById(params);
  }
}
