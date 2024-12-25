abstract class RequestMapable {
  Map<String, dynamic> toJson();
}

abstract class AppAnalyticsEventParams {
  Map<String, dynamic> params();
}

abstract class BaseMapable {
  Map<String, dynamic> toJson();
}
