import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/dashboard/domin/use_cases/get_dashboard_use_case.dart';

class GetDashboardQueryParam extends GetDashboardUseCaseParams implements RequestMapable {
  const GetDashboardQueryParam({required super.filterDto});

  factory GetDashboardQueryParam.fromParams(GetDashboardUseCaseParams params) {
    return GetDashboardQueryParam(filterDto: params.filterDto);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (filterDto?.fromDate != null) 'start': filterDto?.fromDate?.toIso8601String(),
      if (filterDto?.toDate != null) 'end': filterDto?.toDate?.toIso8601String(),
    };
  }
}
