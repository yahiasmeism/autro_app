import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/update_packing_list_use_case.dart';

class UpdatePackingListRequest extends UpdatePackingListUseCaseParams implements RequestMapable {
  const UpdatePackingListRequest({
    required super.containerNumber,
    required super.weight,
    required super.vgm,
    required super.date,
    required super.percent,
    required super.id,
  });

  factory UpdatePackingListRequest.fromParams(UpdatePackingListUseCaseParams params) {
    return UpdatePackingListRequest(
      containerNumber: params.containerNumber,
      weight: params.weight,
      vgm: params.vgm,
      date: params.date,
      percent: params.percent,
      id: params.id,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'containerNumber': containerNumber,
      'weight': weight,
      'vgm': vgm,
      'date': date.formattedDateMMMDDY,
      'percent': percent,
      'id': id,
    };
  }
}
