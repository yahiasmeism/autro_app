import 'package:autro_app/core/extensions/list_extension.dart';

import '../../../interfaces/mapable.dart';

class PaginationListResponse<T extends BaseMapable> {
  final List<T> data;
  final int total;
  PaginationListResponse({
    required this.data,
    this.total = 0,
  });

  factory PaginationListResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    final dataList = (json["data"] as List?).orEmpty.map((item) => fromJson(item)).toList();

    return PaginationListResponse<T>(
      data: dataList,
      total: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
