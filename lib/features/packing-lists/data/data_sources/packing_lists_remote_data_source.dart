import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/packing-lists/data/model/requests/get_all_packing_lists_request.dart';

import '../model/packing_list_model.dart';
import '../model/requests/create_packing_list_request.dart';
import '../model/requests/update_packing_list_request.dart';

abstract class PackingListsRemoteDataSource {
  Future<PackingListModel> getPackingList(int id);
  Future<PaginationListResponse<PackingListModel>> getPackingLists(GetAllPackingListsRequest body);
  Future<PackingListModel> createPackingList(CreatePackingListRequest body);
  Future<PackingListModel> updatePackingList(UpdatePackingListRequest body);
  Future<PackingListModel> deletePackingList(int id);
}

class PackingListsRemoteDataSourceImpl implements PackingListsRemoteDataSource {
  final ApiClient apiClient;

  PackingListsRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<PackingListModel> createPackingList(CreatePackingListRequest body) async {
    const path = ApiPaths.packingLists;
    final reqeust = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.post(reqeust);

    if (ResponseCode.isOk(response.statusCode)) {
      return PackingListModel.fromJson(response.data);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<PackingListModel> deletePackingList(int id) async {
    final path = ApiPaths.packingListById(id);
    final request = ApiRequest(path: path);
    final response = await apiClient.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return PackingListModel.fromJson(response.data);
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<PackingListModel> getPackingList(int id) async {
    final path = ApiPaths.packingListById(id);
    final request = ApiRequest(path: path);
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return PackingListModel.fromJson(response.data);
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<PaginationListResponse<PackingListModel>> getPackingLists(GetAllPackingListsRequest body) async {
    const path = ApiPaths.packingLists;
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return PaginationListResponse.fromJson(response.data, (json) => PackingListModel.fromJson(json));
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<PackingListModel> updatePackingList(UpdatePackingListRequest body) async {
    final path = ApiPaths.packingListById(body.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return PackingListModel.fromJson(response.data);
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }
}
