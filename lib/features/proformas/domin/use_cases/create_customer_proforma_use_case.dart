import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/customers_proformas_repository.dart';

@lazySingleton
class CreateCustomerProformaUseCase extends UseCase<CustomerProformaEntity, CreateCustomerProformaUseCaseParams> {
  final CustomersProformasRepository repository;

  CreateCustomerProformaUseCase({required this.repository});
  @override
  Future<Either<Failure, CustomerProformaEntity>> call(CreateCustomerProformaUseCaseParams params) async {
    return await repository.createCustomerProforma(params);
  }
}

class CreateCustomerProformaUseCaseParams extends Equatable {
  final String? proformaNumber;
  final String date;
  final int customerId;
  final String taxId;
  final String ports;
  final String deliveryTerms;
  final String paymentTerms;
  final int bankAccountId;
  final String notes;
  final List<CustomerProformaDescriptionParams> descriptions;

  const CreateCustomerProformaUseCaseParams({
    required this.proformaNumber,
    required this.date,
    required this.customerId,
    required this.taxId,
    required this.ports,
    required this.deliveryTerms,
    required this.paymentTerms,
    required this.bankAccountId,
    required this.notes,
    required this.descriptions,
  });
  @override
  List<Object?> get props => [
        proformaNumber,
        date,
        customerId,
        // customerAddress,
        taxId,
        ports,
        deliveryTerms,
        paymentTerms,
        bankAccountId,
        notes,
        descriptions,
      ];
}

class CustomerProformaDescriptionParams extends Equatable {
  final String description;
  final int containersCount;
  final double weight;
  final double unitPrice;
  final String packing;

  const CustomerProformaDescriptionParams({
    required this.description,
    required this.containersCount,
    required this.weight,
    required this.unitPrice,
    required this.packing,
  });
  @override
  List<Object?> get props => [
        description,
        containersCount,
        weight,
        unitPrice,
        packing,
      ];
}
