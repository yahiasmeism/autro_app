import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/data/responses/pagination_list_response.dart';
import '../../models/deal_bill_model.dart';
import '../../models/requests/create_deal_bill_request.dart';
import '../../models/requests/get_deal_bills_list_request.dart';
import '../../models/requests/update_deal_bill_request.dart';

abstract class DealsBillsRemoteDataSource {
  Future<DealBillModel> createDealBill(CreateDealBillRequest body);

  Future<DealBillModel> updateDealBill(UpdateDealBillRequest body);

  Future<void> deleteDealBill(int billId);

  Future<PaginationListResponse<DealBillModel>> getDealsBillsList(GetDealBillsListRequest body);
}

@LazySingleton(as: DealsBillsRemoteDataSource)
class DealsBillsRemoteDataSourceImpl implements DealsBillsRemoteDataSource {
  final ApiClient apiClient;

  DealsBillsRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<DealBillModel> createDealBill(CreateDealBillRequest body) async {
    final path = ApiPaths.dealBills(body.dealId);
    final request = ApiRequest(path: path, body: await body.toFormData());
    final response = await apiClient.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return DealBillModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<void> deleteDealBill(int billId) async {
    final path = ApiPaths.dealBillById(billId);
    final request = ApiRequest(path: path);
    final response = await apiClient.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<DealBillModel>> getDealsBillsList(GetDealBillsListRequest body) async {
    final path = ApiPaths.dealBills(body.dealId);
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, DealBillModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<DealBillModel> updateDealBill(UpdateDealBillRequest body) async {
    final path = ApiPaths.dealBillById(body.id);
    final request = ApiRequest(path: path, body: await body.toFormData());
    final response = await apiClient.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return DealBillModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
