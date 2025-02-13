import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../models/requests/create_bl_instruction_request.dart';
import '../../models/requests/get_bl_instructions_list_request.dart';
import '../../models/requests/update_bl_instruction_request.dart';
import '../../models/bl_instruction_model.dart';

abstract class BlInsturctionsRemoteDateSource {
  Future<PaginationListResponse<BlInsturctionModel>> getBlInsturctionsList(GetBlInstructionsListRequest body);

  Future<BlInsturctionModel> getBlInsturction(int id);

  Future<BlInsturctionModel> createBlInsturction(CreateBlInsturctionRequest body);

  Future<BlInsturctionModel> updateBlInsturction(UpdateBlInsturctionRequest body);

  Future<void> deleteBlInsturction(int id);
}

@LazySingleton(as: BlInsturctionsRemoteDateSource)
class BlInsturctionsRemoteDateSourceImpl implements BlInsturctionsRemoteDateSource {
  final ApiClient client;

  BlInsturctionsRemoteDateSourceImpl({required this.client});
  @override
  Future<BlInsturctionModel> createBlInsturction(CreateBlInsturctionRequest body) async {
    const path = ApiPaths.blInstructions;
    final request = ApiRequest(path: path, body: await body.toFormData());
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return BlInsturctionModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<void> deleteBlInsturction(int id) async {
    final path = ApiPaths.blInstructionById(id);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<BlInsturctionModel> getBlInsturction(int id) async {
    final path = ApiPaths.blInstructionById(id);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return BlInsturctionModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<BlInsturctionModel>> getBlInsturctionsList(GetBlInstructionsListRequest body) async {
    const path = ApiPaths.blInstructions;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, BlInsturctionModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<BlInsturctionModel> updateBlInsturction(UpdateBlInsturctionRequest body) async {
    final path = ApiPaths.blInstructionById(body.id);
    final request = ApiRequest(path: path, body: await body.toFormData());
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return BlInsturctionModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
