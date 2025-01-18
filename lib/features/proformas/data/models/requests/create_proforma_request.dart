import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/data/models/requests/create_proforma_description_request.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_proforma_use_case.dart';

class CreateProformaRequest extends CreateProformaUseCaseParams implements RequestMapable {
  const CreateProformaRequest({
    required super.proformaNumber,
    required super.date,
    required super.customerId,
    required super.address,
    required super.taxId,
    required super.ports,
    required super.deliveryTerms,
    required super.paymentTerms,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
  });

  factory CreateProformaRequest.fromParams(CreateProformaUseCaseParams params) {
    return CreateProformaRequest(
      proformaNumber: params.proformaNumber,
      date: params.date,
      customerId: params.customerId,
      address: params.address,
      taxId: params.taxId,
      ports: params.ports,
      deliveryTerms: params.deliveryTerms,
      paymentTerms: params.paymentTerms,
      bankAccountId: params.bankAccountId,
      notes: params.notes,
      descriptions: params.descriptions,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "proforma_number": proformaNumber,
      "date": date,
      "customer_id": customerId,
      "address": address,
      "tax_id": taxId,
      "ports": ports,
      "delivery_terms": deliveryTerms,
      "payment_terms": paymentTerms,
      "bank_account_id": bankAccountId,
      "notes": notes,
      "descriptions": descriptions.map(
        (e) => CreateProformaDescriptionRequest.fromParams(e).toJson(),
      ),
    };
  }
}
