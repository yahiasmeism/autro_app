import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/create_packing_list_use_case.dart';

class CreatePackingListRequest extends CreatePackingListUseCaseParams implements RequestMapable {
  const CreatePackingListRequest({
    required super.containerNumber,
    required super.weight,
    required super.vgm,
    required super.date,
    required super.percent,
  });

  factory CreatePackingListRequest.fromParams(CreatePackingListUseCaseParams params) {
    return CreatePackingListRequest(
      containerNumber: params.containerNumber,
      weight: params.weight,
      vgm: params.vgm,
      date: params.date,
      percent: params.percent,
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
    };
  }
}
