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
  final bool loading;
  const DashboardLoaded({
    required this.dashboard,
    this.failure = const None(),
    this.loading = false,
  });

  List<ActivityEntity> get latest10Activity => dashboard.lastActivities.take(10).toList();

  @override
  List<Object> get props => [dashboard, failure, loading];

  DashboardLoaded copyWith({
    DashboardEntity? dashboard,
    Option<Failure>? failure,
    bool? loading,
  }) {
    return DashboardLoaded(
      dashboard: dashboard ?? this.dashboard,
      failure: failure ?? this.failure,
      loading: loading ?? this.loading,
    );
  }
}

class DashboardError extends DashboardState {
  final Failure failure;

  const DashboardError({required this.failure});
}
