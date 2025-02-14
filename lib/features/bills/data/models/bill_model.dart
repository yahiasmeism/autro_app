import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/bills/domin/entities/bill_entity.dart';

class BillModel extends BillEntity implements BaseMapable {
  const BillModel({
    required super.id,
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
    required super.createdAt,
    required super.attachmentUrl,
    required super.vat,
    required super.updatedAt,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: (json['id'] as num?).toIntOrZero,
      vendor: (json['vendor'] as String?).orEmpty,
      amount: (json['amount'] as num?).toDoubleOrZero,
      notes: (json['notes'] as String?).orEmpty,
      date: DateTime.parse((json['date'] as String?).orEmpty).orDefault,
      createdAt: DateTime.parse((json['created_at'] as String?).orEmpty).orDefault,
      updatedAt: DateTime.parse((json['updated_at'] as String?).orEmpty).orDefault,
      attachmentUrl: (json['attachment'] as String?).orEmpty,
      vat: (json['vat'] as num?).toDoubleOrZero,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor': vendor,
      'amount': amount,
      'notes': notes,
      'date': date,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'vat': vat,
    };
  }
}
