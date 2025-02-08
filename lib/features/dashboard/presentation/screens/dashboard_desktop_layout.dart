import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/dashboard/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:autro_app/features/dashboard/presentation/widgets/dashboard_filter_dialog.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(105),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Accounting & Analytics Dashboard'),
                actions: [_buildActions()],
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoaded) {
            state.failure.fold(
              () {},
              (a) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(a)),
            );
          }
        },
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

  Widget _buildActions() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 28,
                  ),
                  onPressed: !state.loading
                      ? () {
                          context.read<DashboardCubit>().refresh();
                        }
                      : null,
                ),
                Badge(
                  backgroundColor: Colors.red,
                  alignment: const Alignment(-.45, -.55),
                  isLabelVisible: state.filterDto.isSome(),
                  largeSize: 8,
                  smallSize: 8,
                  child: IconButton(
                    icon: const Icon(Icons.filter_alt_outlined, size: 28),
                    onPressed: !state.loading
                        ? () {
                            DashboardFilterDialog.show(
                              context,
                              filter: state.filterDto.fold(
                                () => null,
                                (a) => a,
                              ),
                            );
                          }
                        : null,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
