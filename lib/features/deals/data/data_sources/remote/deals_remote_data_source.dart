import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/deal_model.dart';
import '../../models/requests/create_deal_request.dart';
import '../../models/requests/get_proformas_list_request.dart';
import '../../models/requests/update_deal_request.dart';

abstract class DealsRemoteDataSource {
  Future<DealModel> createDeal(CreateDealRequest body);
  Future<Unit> deleteDeal(int dealId);
  Future<DealModel> getDealById(int dealId);
  Future<PaginationListResponse<DealModel>> getDealsList(GetDealsListRequest body);
  Future<DealModel> updateDeal(UpdateDealRequest body);
}

@LazySingleton(as: DealsRemoteDataSource)
class DealsRemoteDataSourceImpl implements DealsRemoteDataSource {
  final ApiClient client;

  DealsRemoteDataSourceImpl({required this.client});
  @override
  Future<DealModel> createDeal(CreateDealRequest body) async {
    const path = ApiPaths.deals;
    final json = body.toJson();
    final request = ApiRequest(path: path, body: json);
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return DealModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<Unit> deleteDeal(int dealId) async {
    final path = ApiPaths.dealById(dealId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return unit;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<DealModel> getDealById(int dealId) async {
    final path = ApiPaths.dealById(dealId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return DealModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<DealModel>> getDealsList(GetDealsListRequest body) async {
    const path = ApiPaths.deals;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, DealModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<DealModel> updateDeal(UpdateDealRequest body) async {
    final path = ApiPaths.dealById(body.dealId);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return DealModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
