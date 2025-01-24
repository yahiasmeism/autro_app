import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/domin/entities/invoice_goods_description_entity.dart';

class InvoiceGoodsDescriptionModel extends InvoiceGoodsDescriptionEntity implements BaseMapable {
  const InvoiceGoodsDescriptionModel({
    required super.id,
    required super.description,
    required super.weight,
    required super.unitPrice,
    required super.createdAt,
    required super.updatedAt,
    required super.containerNumber,
    required super.totalPrice,
  });

  factory InvoiceGoodsDescriptionModel.fromJson(Map<String, dynamic> json) {
    return InvoiceGoodsDescriptionModel(
      id: (json['id'] as int?).toIntOrZero,
      description: (json['description'] as String?).orEmpty,
      containerNumber: (json['container_number'] as String?).orEmpty,
      weight: (json['weight'] as num?).toDoubleOrZero,
      unitPrice: (json['unit_price'] as num?).toDoubleOrZero,
      createdAt: DateTime.tryParse((json['created_at'] as String?).orEmpty).orDefault,
      updatedAt: DateTime.tryParse((json['updated_at'] as String?).orEmpty).orDefault,
      totalPrice: (json['total_amount'] as num?).toDoubleOrZero,
    );
  }

  factory InvoiceGoodsDescriptionModel.fromParams(InvoiceGoodsDescriptionEntity params) {
    return InvoiceGoodsDescriptionModel(
      id: params.id,
      description: params.description,
      containerNumber: params.containerNumber,
      weight: params.weight,
      unitPrice: params.unitPrice,
      createdAt: params.createdAt,
      updatedAt: params.updatedAt,
      totalPrice: params.totalPrice,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "container_number": containerNumber,
      "weight": weight,
      "unit_price": unitPrice,
    };
  }
}
