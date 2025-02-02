import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/data/models/requests/customer_proforma_description_request.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_customer_proforma_use_case.dart';

class CreateCustomerProformaRequest extends CreateCustomerProformaUseCaseParams implements RequestMapable {
  const CreateCustomerProformaRequest({
    required super.proformaNumber,
    required super.date,
    required super.customerId,
    // required super.customerAddress,
    required super.taxId,
    required super.ports,
    required super.deliveryTerms,
    required super.paymentTerms,
    required super.bankAccountId,
    required super.notes,
    required super.descriptions,
  });

  factory CreateCustomerProformaRequest.fromParams(CreateCustomerProformaUseCaseParams params) {
    return CreateCustomerProformaRequest(
      proformaNumber: params.proformaNumber,
      date: params.date,
      customerId: params.customerId,
      // customerAddress: params.customerAddress,
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
    if(proformaNumber != null)  "proforma_number": proformaNumber,
      "date": date,
      "customer_id": customerId,
      // "customer_address": customerAddress,
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
