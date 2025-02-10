import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/create_packing_list_use_case.dart';

class CreatePackingListRequest extends CreatePackingListUseCaseParams implements RequestMapable {
  const CreatePackingListRequest({
    required super.details,
    required super.number,
    required super.dealId,
    required super.descriptions,
    required super.taxId,
  });

  factory CreatePackingListRequest.fromParams(CreatePackingListUseCaseParams params) => CreatePackingListRequest(
        details: params.details,
        number: params.number,
        dealId: params.dealId,
        descriptions: params.descriptions,
        taxId: params.taxId,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'tax_id': taxId,
      'details': details,
      'number': number,
      'deal_id': dealId,
      'descriptions': descriptions.map((e) => e.toJson()).toList(),
    };
  }
}
