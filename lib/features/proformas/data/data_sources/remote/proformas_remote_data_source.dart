import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/proforma_model.dart';
import '../../models/requests/create_proforma_request.dart';
import '../../models/requests/get_proformas_list_request.dart';

abstract class ProformasRemoteDataSource {
  Future<ProformaModel> createProforma(CreateProformaRequest body);
  Future<Unit> deleteProforma(int proformaId);
  Future<ProformaModel> getProformaById(int proformaId);
  Future<PaginationListResponse<ProformaModel>> getProformasList(GetProformasListRequest body);
  Future<ProformaModel> updateProforma(ProformaModel proformaId);
}

@LazySingleton(as: ProformasRemoteDataSource)
class ProformasRemoteDataSourceImpl implements ProformasRemoteDataSource {
  final ApiClient client;

  ProformasRemoteDataSourceImpl({required this.client});
  @override
  Future<ProformaModel> createProforma(CreateProformaRequest body) async {
    const path = ApiPaths.proformas;
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return ProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<Unit> deleteProforma(int proformaId) async {
    final path = ApiPaths.proformaById(proformaId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return unit;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<ProformaModel> getProformaById(int proformaId) async {
    final path = ApiPaths.proformaById(proformaId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return ProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<ProformaModel>> getProformasList(GetProformasListRequest body) async {
    const path = ApiPaths.proformas;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, ProformaModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<ProformaModel> updateProforma(ProformaModel proformaId) async {
    final path = ApiPaths.proformaById(proformaId.id);
    final request = ApiRequest(path: path, body: proformaId.toJson());
    final response = await client.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return ProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
