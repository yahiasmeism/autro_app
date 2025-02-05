import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:autro_app/features/suppliers/data/models/supplier_model.dart';

class SupplierProformaModel extends SupplierProformaEntity implements BaseMapable {
  const SupplierProformaModel({
    required super.id,
    required super.number,
    required super.supplierId,
    required super.dealId,
    required super.totalAmount,
    required super.attachmentUrl,
    required super.date,
    required super.material,
    required super.supplier,
  });

  factory SupplierProformaModel.fromJson(Map<String, dynamic> json) {
    return SupplierProformaModel(
      id: (json['id'] as int?).toIntOrZero,
      number: (json['number'] as String?).orEmpty,
      supplierId: (json['supplier_id'] as int?).toIntOrZero,
      dealId: (json['deal_id'] as int?).toIntOrZero,
      totalAmount: (json['total_amount'] as num?).toDoubleOrZero,
      attachmentUrl: (json['attachment'] as String?).orEmpty,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      material: (json['material'] as String?).orEmpty,
      supplier: SupplierModel.fromJson((json['supplier'] as Map<String, dynamic>).orEmpty),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
