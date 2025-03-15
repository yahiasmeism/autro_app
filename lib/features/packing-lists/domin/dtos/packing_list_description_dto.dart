import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/packing-lists/domin/dtos/packing_list_controllers_dto.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity_descirption.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PackingListDescriptionDto extends Equatable {
  final String uniqueKey;
  final String containerNumber;
  final double weight;
  final double emptyContainerWeight;
  final String? type;
  final int itemsCount;
  final DateTime date;
  final String percento;

  const PackingListDescriptionDto({
    required this.containerNumber,
    required this.weight,
    required this.emptyContainerWeight,
    required this.type,
    required this.itemsCount,
    required this.date,
    required this.percento,
    required this.uniqueKey,
  });

  @override
  List<Object?> get props => [containerNumber, weight, emptyContainerWeight, type, itemsCount, date, percento, uniqueKey];

  factory PackingListDescriptionDto.fromEntity(PackingListDescriptionEntity entity) => PackingListDescriptionDto(
        containerNumber: entity.containerNumber,
        weight: entity.weight,
        emptyContainerWeight: entity.emptyContainerWeight,
        type: entity.type,
        itemsCount: entity.itemsCount,
        date: entity.date,
        percento: entity.precinto,
        uniqueKey: entity.id.toString(),
      );

  double get vgm => weight + emptyContainerWeight;

  PackingListDescriptionDto copyWith({
    String? containerNumber,
    double? weight,
    double? emptyContainerWeight,
    String? type,
    int? itemsCount,
    DateTime? date,
    String? percento,
  }) {
    return PackingListDescriptionDto(
      containerNumber: containerNumber ?? this.containerNumber,
      weight: weight ?? this.weight,
      emptyContainerWeight: emptyContainerWeight ?? this.emptyContainerWeight,
      type: type ?? this.type,
      itemsCount: itemsCount ?? this.itemsCount,
      date: date ?? this.date,
      percento: percento ?? this.percento,
      uniqueKey: uniqueKey,
    );
  }

  PackingListControllersDto toControllersDTO() => PackingListControllersDto(
        containerNumber: TextEditingController(text: containerNumber),
        weight: TextEditingController(text: weight.toString()),
        emptyContainerWeight: TextEditingController(text: emptyContainerWeight.toString()),
        type: TextEditingController(text: type),
        itemsCount: TextEditingController(text: itemsCount.toString()),
        date: TextEditingController(text: date.formattedDateYYYYMMDD),
        percento: TextEditingController(text: percento),
        uniqueKey: uniqueKey,
        vgm: TextEditingController(text: vgm.toString()),
      );
  Map<String, dynamic> toJson() => {
        'container_number': containerNumber,
        'weight': weight,
        'empty_container_weight': emptyContainerWeight,
        'type': type?.toLowerCase(),
        'items_count': itemsCount,
        'date': date.formattedDateYYYYMMDD,
        'precinto': percento,
      };
}
