import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity_descirption.dart';

class PackingListDescriptionModel extends PackingListDescriptionEntity {
  const PackingListDescriptionModel({
    required super.packingListId,
    required super.containerNumber,
    required super.weight,
    required super.date,
    required super.emptyContainerWeight,
    required super.precinto,
    required super.id,
    required super.type,
    required super.itemsCount,
  });

  factory PackingListDescriptionModel.fromJson(Map<String, dynamic> json) {
    return PackingListDescriptionModel(
      emptyContainerWeight: (json['empty_container_weight'] as num?).toDoubleOrZero,
      precinto: (json['precinto'] as String?).orEmpty,
      packingListId: (json['packing_list_id'] as int?).toIntOrZero,
      containerNumber: (json['container_number'] as String?).orEmpty,
      weight: (json['weight'] as num?).toDoubleOrZero,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      id: (json['id'] as int?).toIntOrZero,
      itemsCount: (json['items_count'] as int?).toIntOrZero,
      type: (json['type'] as String?).orEmpty,
    );
  }
}
