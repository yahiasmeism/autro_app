import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/skeleton_container.dart';

class BillsSummaryTopSection extends StatelessWidget {
  const BillsSummaryTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsListBloc, BillsListState>(
      builder: (context, state) {
        double amount = 0;
        int count = 0;
        double totalAfterVat = 0;
        bool loading = state is BillsListInitial;
        if (state is BillsListLoaded) {
          amount = state.billsSummary?.totalAmount ?? 0.0;
          count = state.billsSummary?.totalBillsCount ?? 0;
          loading = state.loadingSummary;
          totalAfterVat = state.billsSummary?.totalAfterVat ?? 0;
        }
        return Row(
          children: [
            Expanded(
              child: _buildTotalBillsAmount(amount, loading),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTotalAfterVat(totalAfterVat, loading),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildBillsCount(count, loading),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTotalBillsAmount(double amount, bool loading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.iconsDollar, width: 60, height: 60),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Bills Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              loading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: SkeletonContainer.rounded(width: 100, height: 16),
                    )
                  : Text(
                      '€${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAfterVat(double totalAfterVat, bool loading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.iconsDollar, width: 60, height: 60),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total After Vat',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              loading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: SkeletonContainer.rounded(width: 100, height: 16),
                    )
                  : Text(
                      '€${totalAfterVat.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillsCount(int count, bool loading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.iconsTimeHalf, width: 60, height: 60),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Bills Count',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              loading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: SkeletonContainer.rounded(width: 50, height: 16),
                    )
                  : Text(
                      count.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
