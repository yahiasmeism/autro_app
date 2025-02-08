import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/features/dashboard/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/text_styles.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previous, current) => current is DashboardLoaded,
      builder: (context, state) {
        if (state is DashboardLoaded) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Revenue',
                      value: "€${state.dashboard.totalRevenue.toStringAsFixed(2)}",
                      svg: Assets.iconsDollar,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Expenses',
                      value: "€${state.dashboard.totalExpenses.toStringAsFixed(2)}",
                      svg: Assets.iconsExpenses,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Net Profit',
                      value: "€${state.dashboard.netProfit.toStringAsFixed(2)}",
                      svg: Assets.iconsNetProfit,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Deals',
                      value: state.dashboard.totalDeals.toString(),
                      svg: Assets.iconsDeal,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Active Customers',
                      value: state.dashboard.totalCustomers.toString(),
                      svg: Assets.iconsCustomersIcon,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Top Product',
                      value: state.dashboard.topProduct,
                      svg: Assets.iconsTopProduct,
                    ),
                  ),
                ],
              )
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String svg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(svg, width: 60, height: 60),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyles.font16SemiBold.copyWith(color: AppColors.secondaryOpacity50)),
              const SizedBox(height: 5),
              value.isEmpty
                  ? Text(
                      'Not set yet',
                      style: TextStyles.font16SemiBold.copyWith(color: AppColors.secondaryOpacity25),
                    )
                  : Text(
                      value,
                      style: TextStyles.font16SemiBold,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
