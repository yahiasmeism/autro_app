import 'package:autro_app/core/interfaces/mapable.dart';

import '../../../../../core/common/data/requests/pagination_list_request.dart';

class GetProformasListRequest extends RequestMapable {
  final PaginationFilterRequest paginationFilterRequest;

  GetProformasListRequest({required this.paginationFilterRequest});

  @override
  Map<String, dynamic> toJson() => paginationFilterRequest.toJson();
}
