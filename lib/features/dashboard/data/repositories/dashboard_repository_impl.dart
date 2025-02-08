import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/network_info/network_info.dart';
import 'package:autro_app/features/dashboard/data/models/requests/get_dashboard_query_params.dart';

import 'package:autro_app/features/dashboard/domin/entities/dashboard_entity.dart';
import 'package:autro_app/features/dashboard/domin/use_cases/get_dashboard_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domin/repositories/dashboard_repository.dart';
import '../data_sources/dashboard_remote_data_source.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({required this.dashboardRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, DashboardEntity>> getDashboard(GetDashboardUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final queryParams = GetDashboardQueryParam.fromParams(params);
        final result = await dashboardRemoteDataSource.getDashboard(queryParams);
        return Right(result);
      } catch (e) {
        return Left(ErrorHandler.handle(e));
      }
    } else {
      return Left(ErrorHandler.noInternet());
    }
  }
}
