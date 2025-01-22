import 'package:autro_app/core/extensions/packing_type_extension.dart';

import '../entities/proforma_goods_description_entity.dart';
import '../use_cases/create_proforma_use_case.dart';

class ProformaGoodDescriptionDto extends ProformaDescriptionParams {
  final String uniqueKey;
  const ProformaGoodDescriptionDto({
    required super.description,
    required this.uniqueKey,
    required super.containersCount,
    required super.weight,
    required super.unitPrice,
    required super.packing,
  });

  @override
  List<Object?> get props => [description, uniqueKey, containersCount, weight, unitPrice, packing];

  ProformaGoodDescriptionDto copyWith({
    String? description,
    String? uniqueKey,
    int? containersCount,
    double? weight,
    double? unitPrice,
    String? packing,
  }) {
    return ProformaGoodDescriptionDto(
      description: description ?? this.description,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      containersCount: containersCount ?? this.containersCount,
      weight: weight ?? this.weight,
      unitPrice: unitPrice ?? this.unitPrice,
      packing: packing ?? this.packing,
    );
  }

  double get totalPrice => weight * unitPrice;

  factory ProformaGoodDescriptionDto.fromEntity(ProformaGoodsDescriptionEntity entity) => ProformaGoodDescriptionDto(
        description: entity.description,
        uniqueKey: entity.id.toString(),
        containersCount: entity.containersCount,
        weight: entity.weight,
        unitPrice: entity.unitPrice,
        packing: entity.packing.str,
      );
}
