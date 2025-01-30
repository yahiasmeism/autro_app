import 'package:autro_app/core/interfaces/mapable.dart';

import '../../../../../core/common/data/requests/pagination_list_request.dart';

class GetCustomersInvoicesListRequest extends RequestMapable {
  final PaginationFilterRequest paginationFilterRequest;

  GetCustomersInvoicesListRequest({required this.paginationFilterRequest});

  @override
  Map<String, dynamic> toJson() => paginationFilterRequest.toJson();
}
