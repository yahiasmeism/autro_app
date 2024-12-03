enum ApiRequestMethod { get, post, put, delete }

class ApiRequest {
  final String path;
  final Map<String, dynamic>? queryParameters;
  final Object? body;

  ApiRequest({
    required this.path,
    this.queryParameters,
    this.body,
  });
}

class ApiDynamicRequest extends ApiRequest {
  final String url;
  final bool authenticated;
  final ApiRequestMethod method;
  ApiDynamicRequest({
    required this.url,
    required this.method,
    this.authenticated = false,
    super.body,
    super.queryParameters,
  }) : super(path: url);
}
