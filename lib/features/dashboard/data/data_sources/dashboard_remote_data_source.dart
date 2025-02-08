import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/dashboard/data/models/dashboard_model.dart';
import 'package:autro_app/features/dashboard/data/models/requests/get_dashboard_query_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_request.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> getDashboard(GetDashboardQueryParam queryParams);
}

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;

  DashboardRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<DashboardModel> getDashboard(GetDashboardQueryParam queryParams) async {
    const path = ApiPaths.dashboard;
    final result = await apiClient.get(ApiRequest(path: path, queryParameters: queryParams.toJson()));

    if (ResponseCode.isOk(result.statusCode)) {
      return DashboardModel.fromJson(result.data);
    } else {
      throw ServerException(result.statusCode, result.statusMessage);
    }
  }
}
