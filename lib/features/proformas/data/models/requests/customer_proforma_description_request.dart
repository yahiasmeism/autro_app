import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_customer_proforma_use_case.dart';

class CustomerProformaDescriptionRequest extends CustomerProformaDescriptionParams implements RequestMapable {
  const CustomerProformaDescriptionRequest(
      {required super.description,
      required super.containersCount,
      required super.weight,
      required super.unitPrice,
      required super.packing});

  factory CustomerProformaDescriptionRequest.fromParams(CustomerProformaDescriptionParams params) {
    return CustomerProformaDescriptionRequest(
      description: params.description,
      containersCount: params.containersCount,
      weight: params.weight,
      unitPrice: params.unitPrice,
      packing: params.packing,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "containers_count": containersCount,
      "weight": weight,
      "unit_price": unitPrice,
      "packing": packing.toLowerCase(),
    };
  }
}
