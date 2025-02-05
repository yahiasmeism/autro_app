import 'package:autro_app/core/common/data/requests/pagination_list_request.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/use_cases/get_deals_bills_list_use_case.dart';

class GetDealBillsListRequest extends GetDealsBillsListUseCaseParams implements RequestMapable {
  const GetDealBillsListRequest({required super.dto, required super.dealId});

  factory GetDealBillsListRequest.fromParams(GetDealsBillsListUseCaseParams params) =>
      GetDealBillsListRequest(dto: params.dto, dealId: params.dealId);

  @override
  Map<String, dynamic> toJson() => PaginationFilterRequest.fromDTO(dto).toJson();
}
