import 'package:autro_app/core/interfaces/mapable.dart';

import '../../../../../core/common/data/requests/pagination_list_request.dart';

class GetCustomersListRequest implements RequestMapable {
  final PaginationFilterRequest paginationFilterRequest;
  const GetCustomersListRequest({
    required this.paginationFilterRequest,
  });

  @override
  Map<String, dynamic> toJson() => paginationFilterRequest.toJson();
}
