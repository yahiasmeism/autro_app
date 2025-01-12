import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/storage/hive_box_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/storage/app_preferences.dart';
import '../../../../core/utils/logger_util.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({required String email, required String password});
  Future<Either<Failure, Unit>> register({required String email, required String password, required String name});
  Future<void> logout();
  Future<Either<Failure, UserModel>> getUser();
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
  Future<Either<Failure, UserModel>> login({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.login(email: email, password: password);
        await appPreferences.saveUserToken(user.token);
        await appPreferences.saveAuthState(AuthState.authenticated);
        return Right(user);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
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
      await HiveBoxManager.clearAll();
    } on Exception catch (e) {
      LoggerUtils.e(e.toString());
    }
  }

  @override
  Future<Either<Failure, Unit>> register({required String email, required String password, required String name}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.register(email: email, password: password, name: name);
        await appPreferences.saveUserToken(token);
        await appPreferences.saveAuthState(AuthState.authenticated);

        return const Right(unit);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.fetchCurrentUser();
        return Right(user);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
