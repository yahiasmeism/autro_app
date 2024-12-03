abstract class AppException implements Exception {}

class ServerException implements AppException {
  final int code;
  final String? message;

  ServerException(this.code, [this.message]);
}

class CacheException implements AppException {
  final String? message;

  CacheException([this.message]);
}
