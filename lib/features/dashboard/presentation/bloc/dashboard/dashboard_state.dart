part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoaded extends DashboardState {
  final DashboardEntity dashboard;
  final Option<Failure> failure;
  final Option<DashboardFilterDto> filterDto;
  final bool loading;
  const DashboardLoaded({
    required this.dashboard,
    this.failure = const None(),
    this.loading = false,
    this.filterDto = const None(),
  });

  List<ActivityEntity> get latest10Activity => dashboard.lastActivities.take(10).toList();

  @override
  List<Object> get props => [dashboard, failure, loading, dashboard, filterDto];

  DashboardLoaded copyWith({
    DashboardEntity? dashboard,
    Option<Failure>? failure,
    Option<DashboardFilterDto>? filterDto,
    bool? loading,
  }) {
    return DashboardLoaded(
      dashboard: dashboard ?? this.dashboard,
      failure: failure ?? this.failure,
      loading: loading ?? this.loading,
      filterDto: filterDto ?? this.filterDto,
    );
  }
}

class DashboardError extends DashboardState {
  final Failure failure;

  const DashboardError({required this.failure});
}
