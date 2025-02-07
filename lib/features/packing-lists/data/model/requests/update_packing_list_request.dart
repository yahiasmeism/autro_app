import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/update_packing_list_use_case.dart';

class UpdatePackingListRequest extends UpdatePackingListUseCaseParams implements RequestMapable {
  const UpdatePackingListRequest({
    required super.details,
    required super.number,
    required super.dealId,
    required super.descriptions,
    required super.id,
  });

  factory UpdatePackingListRequest.fromParams(UpdatePackingListUseCaseParams params) => UpdatePackingListRequest(
        details: params.details,
        number: params.number,
        dealId: params.dealId,
        descriptions: params.descriptions,
        id: params.id,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'details': details,
      'number': number,
      'deal_id': dealId,
      'descriptions': descriptions.map((e) => e.toJson()).toList(),
    };
  }
}
