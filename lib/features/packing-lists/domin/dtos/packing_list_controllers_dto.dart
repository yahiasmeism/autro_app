import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/packing-lists/domin/dtos/packing_list_description_dto.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity_descirption.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PackingListControllersDto extends Equatable {
  final TextEditingController containerNumber;
  final TextEditingController weight;
  final TextEditingController emptyContainerWeight;
  final TextEditingController? type;
  final TextEditingController itemsCount;
  final TextEditingController date;
  final TextEditingController vgm;
  final TextEditingController percento;
  final String uniqueKey;

  const PackingListControllersDto({
    required this.containerNumber,
    required this.weight,
    required this.emptyContainerWeight,
    required this.type,
    required this.itemsCount,
    required this.date,
    required this.percento,
    required this.uniqueKey,
    required this.vgm,
  });

  @override
  List<Object?> get props => [containerNumber, weight, emptyContainerWeight, type, itemsCount, date, percento];

  factory PackingListControllersDto.fromEntity(PackingListDescriptionEntity entity) => PackingListControllersDto(
        containerNumber: TextEditingController(text: entity.containerNumber),
        weight: TextEditingController(text: entity.weight.toString()),
        emptyContainerWeight: TextEditingController(text: entity.emptyContainerWeight.toString()),
        type: TextEditingController(text: entity.type),
        itemsCount: TextEditingController(text: entity.itemsCount.toString()),
        date: TextEditingController(text: entity.date.formattedDateYYYYMMDD),
        percento: TextEditingController(text: entity.precinto),
        uniqueKey: entity.id.toString(),
        vgm: TextEditingController(text: entity.vgm.toString()),
      );

  PackingListDescriptionDto toDescriptionDTO() => PackingListDescriptionDto(
        uniqueKey: uniqueKey,
        containerNumber: containerNumber.text,
        weight: double.tryParse(weight.text) ?? 0,
        emptyContainerWeight: double.tryParse(emptyContainerWeight.text) ?? 0,
        type: type?.text,
        itemsCount: int.tryParse(itemsCount.text) ?? 0,
        date: DateTime.tryParse(date.text) ?? DateTime.now(),
        percento: percento.text,
      );
}
