class ApiResponse {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  ApiResponse({
    required this.statusCode,
    this.data,
    this.statusMessage,
  });
}
