import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/features/bills/domin/entities/bills_summary_entity.dart';

class BillsSummaryModel extends BillsSummaryEntity {
  const BillsSummaryModel({required super.totalBillsCount, required super.totalAmount, required super.totalAfterVat});

  factory BillsSummaryModel.fromJson(Map<String, dynamic> json) {
    return BillsSummaryModel(
      totalBillsCount: (json['totalCount'] as num?).toIntOrZero,
      totalAmount: (json['totalAmount'] as num?).toDoubleOrZero,
      totalAfterVat: (json['totalAfterVat'] as num?).toDoubleOrZero,
    );
  }
}
