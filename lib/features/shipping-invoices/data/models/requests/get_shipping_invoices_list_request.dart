import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/get_shipping_invoices_list_use_case.dart';

import '../../../../../core/common/data/requests/pagination_list_request.dart';

class GetShippingInvoicesListRequest extends GetShippingInvoicesListUseCaseParams implements RequestMapable {
  const GetShippingInvoicesListRequest({required super.paginationFilterDTO});

  @override
  Map<String, dynamic> toJson() {
    return PaginationFilterRequest.fromDTO(paginationFilterDTO).toJson();
  }
}
