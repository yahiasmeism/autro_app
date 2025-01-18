import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/packing_type_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/domin/entities/proforma_goods_description_entity.dart';

class ProformaGoodsDescriptionModel extends ProformaGoodsDescriptionEntity implements BaseMapable {
  const ProformaGoodsDescriptionModel({
    required super.id,
    required super.description,
    required super.containersCount,
    required super.weight,
    required super.unitPrice,
    required super.packing,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProformaGoodsDescriptionModel.fromJson(Map<String, dynamic> json) {
    return ProformaGoodsDescriptionModel(
      id: (json['id'] as int?).toIntOrZero,
      description: (json['description'] as String?).orEmpty,
      containersCount: (json['containers_count'] as int?).toIntOrZero,
      packing: PackingTypeX.fromString((json['packing'] as String?).orEmpty),
      weight: (json['weight'] as num?).toDoubleOrZero,
      unitPrice: (json['unit_price'] as num?).toDoubleOrZero,
      createdAt: DateTime.tryParse((json['created_at'] as String?).orEmpty).orDefault,
      updatedAt: DateTime.tryParse((json['updated_at'] as String?).orEmpty).orDefault,
    );
  }

  factory ProformaGoodsDescriptionModel.fromParams(ProformaGoodsDescriptionEntity params) {
    return ProformaGoodsDescriptionModel(
      id: params.id,
      description: params.description,
      containersCount: params.containersCount,
      packing: params.packing,
      weight: params.weight,
      unitPrice: params.unitPrice,
      createdAt: params.createdAt,
      updatedAt: params.updatedAt,
    );
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
