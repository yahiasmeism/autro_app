import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/bills/data/models/requests/update_bill_request.dart';

import '../../models/bill_model.dart';
import '../../models/requests/add_bill_request.dart';
import '../../models/requests/get_bills_list_request.dart';

abstract class BillsRemoteDataSource {
  Future<List<BillModel>> getBillsList(GetBillsListRequest body);
  Future<BillModel> addBill(AddBillRequest body);
  Future<BillModel> updateBill(UpdateBillRequest body);
  Future<void> deleteBill(int billId);
  Future<BillModel> getBill(int billId);
}

class BillsRemoteDataSourceImpl implements BillsRemoteDataSource {
  final ApiClient apiClient;

  BillsRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BillModel> addBill(AddBillRequest body) async {
    const path = ApiPaths.bills;
    final request = ApiRequest(path: path, body: body.toJson());
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
  Future<List<BillModel>> getBillsList(GetBillsListRequest body) async {
    const path = ApiPaths.bills;
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return (json as List).map((e) => BillModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<BillModel> updateBill(UpdateBillRequest body) async {
    final path = ApiPaths.billById(body.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BillModel.fromJson(json);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
