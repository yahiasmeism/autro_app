import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity_descirption.dart';

class PackingListDescriptionModel extends PackingListDescriptionEntity {
  const PackingListDescriptionModel({
    required super.packingListId,
    required super.containerNumber,
    required super.weight,
    required super.vgm,
    required super.date,
    required super.percent,
    required super.id,
  });

  factory PackingListDescriptionModel.fromJson(Map<String, dynamic> json) {
    return PackingListDescriptionModel(
      packingListId: (json['packing_list_id'] as int?).toIntOrZero,
      containerNumber: (json['container_number'] as String?).orEmpty,
      weight: (json['weight'] as num?).toDoubleOrZero,
      vgm: (json['vgm'] as num?).toDoubleOrZero,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      percent: (json['percent'] as num?).toDoubleOrZero,
      id: (json['id'] as int?).toIntOrZero,
    );
  }
}
