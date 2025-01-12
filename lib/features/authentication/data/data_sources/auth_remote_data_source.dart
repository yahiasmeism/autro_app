import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_paths.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<String> register({required String email, required String password, required String name});
  Future<void> logout();

  Future<UserModel> fetchCurrentUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<void> logout() async {
    final request = ApiRequest(path: ApiPaths.logout);
    await apiClient.post(request);
  }

  @override
  Future<String> register({required String email, required String password, required String name}) async {
    final body = {'email': email, 'password': password, 'name': name};
    final request = ApiRequest(path: ApiPaths.register, body: body);
    final response = await apiClient.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return response.data['token'] as String? ?? '';
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<UserModel> fetchCurrentUser() async {
    final request = ApiRequest(path: ApiPaths.currentUser);
    final response = await apiClient.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<UserModel> login({required String email, required String password}) async {
    final body = {'email': email, 'password': password};
    final request = ApiRequest(path: ApiPaths.login, body: body);
    final response = await apiClient.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
