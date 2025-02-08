import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/dashboard/domin/dto/dashboard_filter_dto.dart';
import 'package:autro_app/features/dashboard/domin/entities/dashboard_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../repositories/dashboard_repository.dart';

@lazySingleton
class GetDashboardUseCase extends UseCase<DashboardEntity, GetDashboardUseCaseParams> {
  final DashboardRepository dashboardRepository;

  GetDashboardUseCase({required this.dashboardRepository});
  @override
  Future<Either<Failure, DashboardEntity>> call(GetDashboardUseCaseParams params) async {
    return await dashboardRepository.getDashboard(params);
  }
}

class GetDashboardUseCaseParams extends Equatable {
  final DashboardFilterDto? filterDto;

  const GetDashboardUseCaseParams({ this.filterDto});

  @override
  List<Object?> get props => [filterDto];
}
