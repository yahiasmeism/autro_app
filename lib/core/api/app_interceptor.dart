import 'package:dio/dio.dart';
import '../constants/enums.dart';
import '../storage/app_preferences.dart';
import 'api_client.dart';

class AppIntercepters extends Interceptor {
  final AppPreferences appPreferences;
  AppIntercepters({required this.appPreferences});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    /// add the token to the request
    final token = appPreferences.userToken;
    if (appPreferences.authState == AuthState.authenticated) options.headers[AUTHORIZATION] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    /// check if the user is authenticated
    final isUserLoggedIn = appPreferences.authState == AuthState.authenticated;

    /// if the error is 401 and the user is authenticated, then we need to logout
    if (err.response?.statusCode == 401 && isUserLoggedIn) {
      // sl<AppAuthBloc>().add(SessionExpiredAppEvent());
    }
    super.onError(err, handler);
  }
}
