import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/dashboard/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:autro_app/features/dashboard/presentation/widgets/recent_activities.dart';
import 'package:autro_app/features/dashboard/presentation/widgets/top_customers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/statistics_section.dart';

class DashboardDesktopLayout extends StatelessWidget {
  const DashboardDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Accounting & Analytics Dashboard'),
        actions: [_buildRefreshButton()],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardInitial) {
            return const LoadingIndicator();
          } else if (state is DashboardLoaded) {
            return Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          const StatisticsSection(),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: RecentActivities(state: state)),
                              const SizedBox(width: 24),
                              Expanded(flex: 1, child: TopCustomers(state: state)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.loading) const Positioned.fill(child: LoadingOverlay()),
              ],
            );
          } else if (state is DashboardError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<DashboardCubit>().onHandleFailure();
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRefreshButton() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: !state.loading
                  ? () {
                      context.read<DashboardCubit>().refresh();
                    }
                  : null,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
