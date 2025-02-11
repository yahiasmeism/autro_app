import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/bills/domin/dtos/bill_filter_dto.dart';

class GetBillsSummaryQueryParam extends RequestMapable {
  final BillsFilterDto? filterDto;

  GetBillsSummaryQueryParam({required this.filterDto});
  @override
  Map<String, dynamic> toJson() {
    return {
      if (filterDto?.fromDate != null) 'start': filterDto?.fromDate?.toIso8601String(),
      if (filterDto?.toDate != null) 'end': filterDto?.toDate?.toIso8601String(),
    };
  }
}
