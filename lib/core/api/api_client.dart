// ignore_for_file: constant_identifier_names


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../storage/app_preferences.dart';
import 'api_paths.dart';
import 'api_request.dart';
import 'api_response.dart';
import 'app_interceptor.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

abstract class ApiClient {
  Future<ApiResponse> get(ApiRequest request);
  Future<ApiResponse> post(ApiRequest request);
  Future<ApiResponse> put(ApiRequest request);
  Future<ApiResponse> delete(ApiRequest request);
}

@LazySingleton(as: ApiClient)
class DioClient implements ApiClient {
  final AppPreferences appPreferences;
  late Dio _dio;

  DioClient(this.appPreferences) {
    initDio();
  }

  initDio() {
    _dio = Dio();
    const timeOutDur = Duration(seconds: 20);
    final staticHeaders = <String, String>{
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
    };
    _dio.options = BaseOptions(
      baseUrl: ApiPaths.baseUrl,
      connectTimeout: timeOutDur,
      receiveTimeout: timeOutDur,
      headers: staticHeaders,
    );
    if (!kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true));
    }

    _dio.interceptors.add(AppIntercepters(appPreferences: appPreferences));
  }

  ApiResponse _toApiResponse(Response response) {
    final code = response.statusCode ?? -1;
    final data = response.data;
    final message = response.statusMessage;
    return ApiResponse(statusCode: code, statusMessage: message, data: data);
  }

  @override
  Future<ApiResponse> get(ApiRequest request) async {
    final path = request.path;
    final queryParameters = request.queryParameters;
    final data = request.body;
    final result = await _dio.get(path, queryParameters: queryParameters, data: data);
    return _toApiResponse(result);
  }

  @override
  Future<ApiResponse> post(ApiRequest request) async {
    final path = request.path;
    final queryParameters = request.queryParameters;
    final data = request.body;
    final result = await _dio.post(path, queryParameters: queryParameters, data: data);
    return _toApiResponse(result);
  }

  @override
  Future<ApiResponse> put(ApiRequest request) async {
    final path = request.path;
    final queryParameters = request.queryParameters;
    final data = request.body;
    final result = await _dio.put(path, queryParameters: queryParameters, data: data);
    return _toApiResponse(result);
  }

  @override
  Future<ApiResponse> delete(ApiRequest request) async {
    final path = request.path;
    final queryParameters = request.queryParameters;
    final data = request.body;
    final result = await _dio.delete(path, queryParameters: queryParameters, data: data);
    return _toApiResponse(result);
  }
}
