import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/bills/data/models/bills_summary_model.dart';
import 'package:autro_app/features/bills/data/models/requests/get_bills_summary_query_param.dart';
import 'package:autro_app/features/bills/data/models/requests/update_bill_request.dart';
import 'package:injectable/injectable.dart';

import '../../models/bill_model.dart';
import '../../models/requests/add_bill_request.dart';
import '../../models/requests/get_bills_list_request.dart';

abstract class BillsRemoteDataSource {
  Future<PaginationListResponse<BillModel>> getBillsList(GetBillsListRequest body);
  Future<BillModel> addBill(AddBillRequest body);
  Future<BillModel> updateBill(UpdateBillRequest body);
  Future<void> deleteBill(int billId);
  Future<BillModel> getBill(int billId);
  Future<BillsSummaryModel> getBillsSummary(GetBillsSummaryQueryParam queryParam);
}

@LazySingleton(as: BillsRemoteDataSource)
class BillsRemoteDataSourceImpl implements BillsRemoteDataSource {
  final ApiClient apiClient;

  BillsRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BillModel> addBill(AddBillRequest body) async {
    const path = ApiPaths.bills;
    final formData = await body.toFormData();
    final request = ApiRequest(path: path, body: formData);
    final response = await apiClient.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BillModel.fromJson(json);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<void> deleteBill(int billId) async {
    final path = ApiPaths.billById(billId);
    final request = ApiRequest(path: path);
    final response = await apiClient.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<BillModel> getBill(int billId) async {
    final path = ApiPaths.billById(billId);
    final request = ApiRequest(path: path);
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BillModel.fromJson(json);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<BillModel>> getBillsList(GetBillsListRequest body) async {
    const path = ApiPaths.bills;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return PaginationListResponse.fromJson(json, BillModel.fromJson);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<BillModel> updateBill(UpdateBillRequest body) async {
    final path = ApiPaths.billById(body.id);
    final formData = await body.toFormData();

    final request = ApiRequest(path: path, body: formData);
    final response = await apiClient.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BillModel.fromJson(json);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<BillsSummaryModel> getBillsSummary(GetBillsSummaryQueryParam queryParam) async {
    const path = ApiPaths.billsSummary;
    final request = ApiRequest(path: path, queryParameters: queryParam.toJson());
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BillsSummaryModel.fromJson(json);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
