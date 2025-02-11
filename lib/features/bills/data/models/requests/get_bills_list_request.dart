import 'package:autro_app/core/common/data/requests/pagination_list_request.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/bills/domin/use_cases/get_bills_list_use_case.dart';

class GetBillsListRequest extends GetBillsListUseCaseParams implements RequestMapable {
  const GetBillsListRequest({required super.paginationFilterDTO, required super.filterDto});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...(PaginationFilterRequest.fromDTO(paginationFilterDTO).toJson()),
      if (filterDto?.fromDate != null) 'start': filterDto?.fromDate?.toIso8601String(),
      if (filterDto?.toDate != null) 'end': filterDto?.toDate?.toIso8601String(),
    };
  }
}
