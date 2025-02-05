import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/requests/get_suppliers_proforma_list_request.dart';
import '../../models/supplier_proforma_model.dart';
import '../../models/requests/create_supplier_proforma_request.dart';
import '../../models/requests/update_supplier_proforma_request.dart';

abstract class SuppliersProformasRemoteDataSource {
  Future<SupplierProformaModel> createProforma(CreateSupplierProformaRequest body);
  Future<Unit> deleteProforma(int proformaId);
  Future<SupplierProformaModel> getProformaById(int proformaId);
  Future<PaginationListResponse<SupplierProformaModel>> getProformasList(GetSuppliersProformasListRequest body);
  Future<SupplierProformaModel> updateProforma(UpdateSupplierProformaRequest body);
}

@LazySingleton(as: SuppliersProformasRemoteDataSource)
class SuppliersProformasRemoteDataSourceImpl implements SuppliersProformasRemoteDataSource {
  final ApiClient client;

  SuppliersProformasRemoteDataSourceImpl({required this.client});
  @override
  Future<SupplierProformaModel> createProforma(CreateSupplierProformaRequest body) async {
    const path = ApiPaths.supplierProformas;
    final json = await body.toFormDate();
    final request = ApiRequest(path: path, body: json);
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<Unit> deleteProforma(int proformaId) async {
    final path = ApiPaths.supplierProformasById(proformaId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return unit;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<SupplierProformaModel> getProformaById(int proformaId) async {
    final path = ApiPaths.supplierProformasById(proformaId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<SupplierProformaModel>> getProformasList(GetSuppliersProformasListRequest body) async {
    const path = ApiPaths.supplierProformas;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, SupplierProformaModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<SupplierProformaModel> updateProforma(UpdateSupplierProformaRequest body) async {
    final path = ApiPaths.supplierProformasById(body.id);
    final request = ApiRequest(path: path, body: await body.toFormDate());
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
