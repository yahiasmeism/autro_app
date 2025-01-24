import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/use_cases/create_invoice_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/invoices_repository.dart';

@lazySingleton
class UpdateInvoiceUseCase extends UseCase<InvoiceEntity, UpdateInvoiceUseCaseParams> {
  final InvoicesRepository invoicesRepository;

  UpdateInvoiceUseCase({required this.invoicesRepository});
  @override
  Future<Either<Failure, InvoiceEntity>> call(UpdateInvoiceUseCaseParams params) async {
    return await invoicesRepository.updateInvoice(params);
  }
}

class UpdateInvoiceUseCaseParams extends CreateInvoiceUseCaseParams {
  final int id;
  const UpdateInvoiceUseCaseParams({
    required this.id,
    required super.invoiceNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
    required super.proformaId,
  });
}
