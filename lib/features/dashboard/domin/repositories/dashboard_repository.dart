import 'package:autro_app/features/dashboard/domin/use_cases/get_dashboard_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardEntity>> getDashboard(GetDashboardUseCaseParams params);
}
