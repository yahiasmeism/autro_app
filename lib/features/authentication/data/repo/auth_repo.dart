
import 'package:injectable/injectable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/storage/app_preferences.dart';
import '../../../../core/utils/logger_util.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/user_model.dart';

abstract class AuthRepo {
  Future<ApiResult> login({required String email, required String password});
  Future<ApiResult> register({required String email, required String password, required String name});
  Future<void> logout();
  Future<ApiResult<UserModel>> getUser();
  bool get isAuthenticated;
}

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;

  AuthRepoImpl({required this.remoteDataSource, required this.appPreferences, required this.networkInfo});

  @override
  bool get isAuthenticated => appPreferences.authState == AuthState.authenticated;

  @override
  Future<ApiResult> login({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.login(email: email, password: password);
        await appPreferences.saveUserToken(token);
        await appPreferences.saveAuthState(AuthState.authenticated);
        return const ApiResult.success(null);
      } on Exception catch (e) {
        return ApiResult.error(ErrorHandler.handle(e));
      }
    } else {
      return ApiResult.error(ErrorHandler.noInternet());
    }
  }

  @override
  Future<void> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logout();
      } on Exception catch (e) {
        LoggerUtils.e(e.toString());
      }
    }
    try {
      await appPreferences.saveAuthState(AuthState.unauthenticated);
      await appPreferences.removeUserToken();
    } on Exception catch (e) {
      LoggerUtils.e(e.toString());
    }
  }

  @override
  Future<ApiResult> register({required String email, required String password, required String name}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.register(email: email, password: password, name: name);
        await appPreferences.saveUserToken(token);
        await appPreferences.saveAuthState(AuthState.authenticated);

        return const ApiResult.success(null);
      } on Exception catch (e) {
        return ApiResult.error(ErrorHandler.handle(e));
      }
    } else {
      return ApiResult.error(ErrorHandler.noInternet());
    }
  }

  @override
  Future<ApiResult<UserModel>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.fetchCurrentUser();
        return ApiResult.success(user);
      } on Exception catch (e) {
        return ApiResult.error(ErrorHandler.handle(e));
      }
    } else {
      return ApiResult.error(ErrorHandler.noInternet());
    }
  }
}
