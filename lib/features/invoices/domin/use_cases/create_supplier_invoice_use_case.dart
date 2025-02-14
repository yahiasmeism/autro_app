import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/repositories/supplier_invoices_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateSupplierInvoiceUseCase extends UseCase<SupplierInvoiceEntity, CreateSupplierInvoiceUseCaseParams> {
  final SupplierInvoicesRepository repository;

  CreateSupplierInvoiceUseCase({required this.repository});
  @override
  Future<Either<Failure, SupplierInvoiceEntity>> call(CreateSupplierInvoiceUseCaseParams params) async {
    return await repository.createInvoice(params);
  }
}

class CreateSupplierInvoiceUseCaseParams extends Equatable {
  final int dealId;
  final int supplierId;
  final String material;
  final double totalAmount;
  final DateTime date;
  final String? attachementPath;
  final String status;

  const CreateSupplierInvoiceUseCaseParams({
    required this.dealId,
    required this.supplierId,
    required this.material,
    required this.totalAmount,
    required this.date,
    required this.attachementPath,
    required this.status,
  });

  @override
  List<Object?> get props => [
        dealId,
        supplierId,
        material,
        totalAmount,
        date,
        attachementPath,
        status,
      ];
}
