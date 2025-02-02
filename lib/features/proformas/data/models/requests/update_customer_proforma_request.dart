import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/domin/use_cases/update_customer_proforma_use_case.dart';

import 'customer_proforma_description_request.dart';

class UpdateCustomerProformaRequest extends UpdateCustomerProformaUseCaseParams implements RequestMapable {
  const UpdateCustomerProformaRequest({
    required super.id,
    required super.proformaNumber,
    required super.date,
    required super.customerId,
    required super.taxId,
    required super.ports,
    required super.deliveryTerms,
    required super.paymentTerms,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
  });

  factory UpdateCustomerProformaRequest.fromParams(UpdateCustomerProformaUseCaseParams params) => UpdateCustomerProformaRequest(
        id: params.id,
        proformaNumber: params.proformaNumber,
        date: params.date,
        customerId: params.customerId,
        taxId: params.taxId,
        ports: params.ports,
        deliveryTerms: params.deliveryTerms,
        paymentTerms: params.paymentTerms,
        bankAccountId: params.bankAccountId,
        notes: params.notes,
        descriptions: params.descriptions,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "customer_id": customerId,
      "tax_id": taxId,
      "ports": ports,
      "delivary_terms": deliveryTerms,
      "payment_terms": paymentTerms,
      "bank_account_id": bankAccountId,
      "notes": notes,
      "goods_descriptions": descriptions.map((e) => CustomerProformaDescriptionRequest.fromParams(e).toJson()).toList(),
    };
  }
}
