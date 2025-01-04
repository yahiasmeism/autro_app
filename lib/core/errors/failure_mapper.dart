import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/errors/server_failure.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

String _errorMessageByStatusCode(ServerFailure failure) {
  if (!failure.message.isNullOrEmpty) return failure.message!;
  final code = failure.code;
  final error = 'bad_response.$code';
  return error;
}

String _errorMessageFromClientFailure(ClientFailure failure) {
  final code = failure.code;
  final error = 'client_failure.$code';
  return error;
}

String getErrorMsgFromFailure(Failure failure) {
  if (failure is ServerFailure) {
    return _errorMessageByStatusCode(failure);
  }
  if (failure is ClientFailure) {
    return _errorMessageFromClientFailure(failure);
  }
  if (failure is ApiFailure) {
    return _errorMessageOrDefault(failure.message);
  }
  if (failure is GeneralFailure) {
    return _errorMessageOrDefault(failure.message);
  }
  if (failure is NoInternetFailure) {
    return 'No Internet connection available!'.hardcoded;
  }
  return _errorMessageOrDefault(failure.message);
}

/// checks the sent `error` whether it is empty or null and return default error message
/// otherwise the `error` will be returned
String _errorMessageOrDefault(String? error) {
  if (!error.isNullOrEmpty) {
    return error!;
  }
  return 'Something went wrong';
}

IconData getErrorIconFromFailure(Failure failure) {
  if (failure is NoInternetFailure) {
    return Icons.signal_wifi_connected_no_internet_4_rounded;
  }
  return Icons.error_outline_rounded;
}
