import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/suppliers/data/models/requests/create_supplier_request.dart';
import 'package:autro_app/features/suppliers/data/models/requests/get_suppliers_list_request.dart';
import 'package:autro_app/features/suppliers/data/models/supplier_model.dart';
import 'package:injectable/injectable.dart';

import '../models/requests/update_supplier_request.dart';

abstract class SuppliersRemoteDataSource {
  Future<PaginationListResponse<SupplierModel>> getSuppleirsList(GetSuppliersListRequest body);
  Future<SupplierModel> createSupplier(CreateSupplierRequest body);
  Future<SupplierModel> updateSupplier(UpdateSupplierRequest body);
  Future<void> deleteSupplier(int supplierId);
  Future<SupplierModel> getSupplier(int supplierId);
}

@LazySingleton(as: SuppliersRemoteDataSource)
class SuppliersRemoteDataSourceImpl implements SuppliersRemoteDataSource {
  final ApiClient apiClient;

  SuppliersRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<SupplierModel> createSupplier(CreateSupplierRequest body) async {
    const path = ApiPaths.suppliers;
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierModel.fromJson(response.data);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<void> deleteSupplier(int supplierId) async {
    final path = ApiPaths.supplierById(supplierId);
    final request = ApiRequest(path: path);
    final response = await apiClient.delete(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return;
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<SupplierModel> getSupplier(int supplierId) async {
    final path = ApiPaths.supplierById(supplierId);
    final request = ApiRequest(path: path);
    final response = await apiClient.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierModel.fromJson(response.data);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<PaginationListResponse<SupplierModel>> getSuppleirsList(GetSuppliersListRequest body) async {
    const path = ApiPaths.suppliers;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, SupplierModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<SupplierModel> updateSupplier(UpdateSupplierRequest body) async {
    final path = ApiPaths.supplierById(body.supplierModel.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.put(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierModel.fromJson(response.data);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }
}
