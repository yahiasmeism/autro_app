import 'package:autro_app/core/common/data/requests/pagination_list_request.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/get_all_packing_lists_use_case.dart';

class GetAllPackingListsRequest extends GetAllPackingListsUseCaseParams implements RequestMapable {
  const GetAllPackingListsRequest({required super.paginationFilterDTO});

  @override
  Map<String, dynamic> toJson() {
    return PaginationFilterRequest.fromDTO(paginationFilterDTO).toJson();
  }
}
