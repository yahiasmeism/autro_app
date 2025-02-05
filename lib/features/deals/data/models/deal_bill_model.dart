import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/entities/deal_bill_entity.dart';

class DealBillModel extends DealBillEntity implements BaseMapable{
  const DealBillModel({
    required super.id,
    required super.dealId,
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
    required super.attachmentUrl,
  });

  factory DealBillModel.fromJson(Map<String, dynamic> json) {
    return DealBillModel(
      id: (json['id'] as int?).toIntOrZero,
      dealId: (json['deal_id'] as int?).toIntOrZero,
      vendor: (json['vendor'] as String?).orEmpty,
      amount: (json['amount'] as num?).toDoubleOrZero,
      notes: (json['notes'] as String?).orEmpty,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      attachmentUrl: (json['attachment'] as String?).orEmpty,
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deal_id': dealId,
      'vendor': vendor,
      'amount': amount,
      'notes': notes,
      'date': date.formattedDateYYYYMMDD,
      'attachment': attachmentUrl,
    };
  }
}
