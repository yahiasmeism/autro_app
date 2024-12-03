import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/enums.dart';
import '../extensions/auth_state_extension.dart';

abstract class AppPreferences {
  String get userToken;
  AuthState get authState;
  Future<bool> saveUserToken(String token);
  Future<bool> removeUserToken();
  Future<bool> saveAuthState(AuthState state);
}

@LazySingleton(as: AppPreferences)
class AppPreferencesImpl implements AppPreferences {
  final SharedPreferences sharedPreferences;

  // Default values
  static const _defUserToken = '';
  static const _defAuthState = '';

  // Keys
  static const _keyUserToken = 'token';
  static const _kAuthState = '_kAuthState';

  AppPreferencesImpl({required this.sharedPreferences});

  @override
  Future<bool> saveUserToken(String token) async {
    return sharedPreferences.setString(_keyUserToken, token);
  }

  @override
  String get userToken => sharedPreferences.getString(_keyUserToken) ?? _defUserToken;

  @override
  Future<bool> removeUserToken() async {
    return await sharedPreferences.remove(_keyUserToken);
  }

  @override
  Future<bool> saveAuthState(AuthState state) async {
    bool result = await sharedPreferences.setString(_kAuthState, state.name);
    return result;
  }

  @override
  AuthState get authState {
    return AuthStateX.fromString(sharedPreferences.getString(_kAuthState) ?? _defAuthState);
  }
}
