import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/dashboard/domin/entities/activity_entity.dart';
import 'package:autro_app/features/dashboard/domin/entities/dashboard_entity.dart';
import 'package:autro_app/features/dashboard/domin/use_cases/get_dashboard_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/interfaces/use_case.dart';

part 'dashboard_state.dart';

@lazySingleton
class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardUseCase getDashboardUseCase;

  DashboardCubit(this.getDashboardUseCase) : super(DashboardInitial());

  getDashboard() async {
    emit(DashboardInitial());
    final result = await getDashboardUseCase(NoParams());
    result.fold(
      (failure) => emit(DashboardError(failure: failure)),
      (dashboard) => emit(DashboardLoaded(dashboard: dashboard)),
    );
  }

  onHandleFailure() async {
    emit(DashboardInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    await getDashboard();
  }

  refresh() async {
    if (state is DashboardLoaded) {
      final state = this.state as DashboardLoaded;

      emit(state.copyWith(loading: true));

      final result = await getDashboardUseCase(NoParams());

      emit(state.copyWith(loading: false));

      result.fold(
        (failure) => emit(state.copyWith(failure: some(failure))),
        (dashboard) => emit(state.copyWith(dashboard: dashboard)),
      );
    } else if (state is DashboardError) {
      await getDashboard();
    }
  }
}
