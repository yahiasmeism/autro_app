import 'package:autro_app/core/extensions/packing_type_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/domin/use_cases/create_proforma_use_case.dart';

class CreateProformaDescriptionRequest extends CreateProformaDescriptionUseCaseParams implements RequestMapable {
  const CreateProformaDescriptionRequest(
      {required super.description,
      required super.containersCount,
      required super.weight,
      required super.unitPrice,
      required super.packing});

  factory CreateProformaDescriptionRequest.fromParams(CreateProformaDescriptionUseCaseParams params) {
    return CreateProformaDescriptionRequest(
        description: params.description,
        containersCount: params.containersCount,
        weight: params.weight,
        unitPrice: params.unitPrice,
        packing: params.packing);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "containers_count": containersCount,
      "weight": weight,
      "unit_price": unitPrice,
      "packing": packing.str,
    };
  }
}
