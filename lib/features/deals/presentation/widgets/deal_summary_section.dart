import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DealSummarySection extends StatelessWidget {
  const DealSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealDetailsCubit, DealDetailsState>(
      buildWhen: (previous, current) => current is DealDetailsLoaded,
      builder: (context, state) {
        if (state is DealDetailsLoaded) {
          return Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  title: 'Total Revenue',
                  value: state.deal.formattedTotalRevenue,
                  svg: Assets.iconsDollar,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildSummaryCard(
                  title: 'Total Expense',
                  value: state.deal.formattedTotalExpenses,
                  svg: Assets.iconsExpenses,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildSummaryCard(
                  title: 'Net Profit',
                  value: state.deal.formattedNetProfit,
                  svg: Assets.iconsNetProfit,
                ),
              ),
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
              Text(title, style: TextStyles.font16SemiBold),
              const SizedBox(height: 5),
              Text(
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
