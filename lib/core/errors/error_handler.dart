// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failures.dart';
import 'server_failure.dart';

class ErrorHandler implements Exception {
  static Failure handle(dynamic error) {
    if (error is ServerException) {
      final code = error.code;
      final message = error.message;
      return _handleExceptionByResponseCode(code, message);
    } else if (error is DioException) {
      return _handleDioException(error);
    } else {
      // default error
      return GeneralFailure(message: error.toString());
    }
  }

  static Failure noInternet() => const NoInternetFailure();

  static Failure _handleExceptionByResponseCode(int code, String? message) {
    switch (code) {
      case ResponseCode.BAD_REQUEST:
        return BadRequestFailure(message: message);
      case ResponseCode.UNAUTHORISED:
        return UnauthorizedFailure(message);
      case ResponseCode.FORBIDDEN:
        return const ForbiddenFailure();
      case ResponseCode.NOT_FOUND:
        return const NotFoundFailure();
      case ResponseCode.INTERNAL_SERVER_ERROR:
        return InternalServerFailure(message: message);
      case ResponseCode.BAD_GATEWAY:
        return const BadGatewayFailure();
      case ResponseCode.SERVICE_UNAVAILABLE:
        return const ServiceUnavailableFailure();
      case ResponseCode.GATEWAY_TIMEOUT:
        return const GatewayTimeoutFailure();
      case ResponseCode.TEAPOT:
        return const TeapotFailure();
      default:
        return ServerFailure(code: code, message: message);
    }
  }

  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badCertificate:
        return const BadCertificateFailure();
      case DioExceptionType.cancel:
        return const RequestCanceledFailure();
      case DioExceptionType.connectionError:
        return const ConnectionErrorFailure();
      case DioExceptionType.connectionTimeout:
        return const ConnectionTimeoutFailure();
      case DioExceptionType.receiveTimeout:
        return const ReceiveTimeoutFailure();
      case DioExceptionType.sendTimeout:
        return const SendTimeoutFailure();
      case DioExceptionType.badResponse:
        final code = exception.response?.statusCode ?? -1;
        String? message = exception.response?.data['message'] ??
            _getErrorMessageFromMap(exception.response?.data['error'] ?? {}) ??
            exception.message;
        return _handleExceptionByResponseCode(code, message);

      default:
        return const GeneralFailure();
    }
  }

  static String? _getErrorMessageFromMap(Map<String, dynamic> map) {
    String message = '';
    for (var value in map.values) {
      if (value is String) {
        message += '$value\n';
      } else if (value is List) {
        message += value[0] + '\n';
      }
    }
    return message.isEmpty ? null : message.trim();
  }
}

abstract class ResponseCode {
  // API status codes
  static const int SUCCESS = 200; // success with data
  static const int SUCCESS_NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failure, api rejected the request
  static const int UNAUTHORISED = 401; // failure user is not authorised
  static const int FORBIDDEN = 403; // failure, api rejected the request
  static const int NOT_FOUND = 404; // failure, api url is not correct and not found
  static const int TEAPOT = 418; // I'm a teapot!
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash happened in server side
  static const int BAD_GATEWAY = 502; // failure, the server is having trouble connecting to another service
  static const int SERVICE_UNAVAILABLE = 503; // failure, services are temporarily unavailable
  static const int GATEWAY_TIMEOUT = 504; // failure, The server is taking too long to respond

  static isOk(int code) => code == SUCCESS || code == SUCCESS_NO_CONTENT;
}
