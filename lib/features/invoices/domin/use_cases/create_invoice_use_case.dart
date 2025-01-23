import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/invoices/domin/entities/invoice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/invoices_repository.dart';

@lazySingleton
class CreateInvoiceUseCase extends UseCase<InvoiceEntity, CreateInvoiceUseCaseParams> {
  final InvoicesRepository repository;

  CreateInvoiceUseCase({required this.repository});
  @override
  Future<Either<Failure, InvoiceEntity>> call(CreateInvoiceUseCaseParams params) async {
    return await repository.createInvoice(params);
  }
}

class CreateInvoiceUseCaseParams extends Equatable {
  final int customerId;
  final int proformaId;
  final int bankAccountId;
  final String invoiceNumber;
  final String date;
  final String taxId;
  final String notes;
  final List<InvoiceGoodDescriptionParams> descriptions;

  const CreateInvoiceUseCaseParams({
    required this.invoiceNumber,
    required this.date,
    required this.customerId,
    required this.taxId,
    required this.bankAccountId,
    required this.notes,
    required this.descriptions,
    required this.proformaId,
  });
  @override
  List<Object?> get props => [
        invoiceNumber,
        date,
        customerId,
        taxId,
        bankAccountId,
        notes,
        descriptions,
      ];
}

class InvoiceGoodDescriptionParams extends Equatable {
  final String description;
  final double weight;
  final double unitPrice;
  final String containerNumber;

  const InvoiceGoodDescriptionParams({
    required this.description,
    required this.weight,
    required this.unitPrice,
    required this.containerNumber,
  });
  @override
  List<Object?> get props => [
        description,
        weight,
        unitPrice,
        containerNumber,
      ];
}
