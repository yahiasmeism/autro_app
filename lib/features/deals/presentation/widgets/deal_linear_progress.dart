import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealLinearProgress extends StatelessWidget {
  const DealLinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealDetailsCubit, DealDetailsState>(
      buildWhen: (previous, current) => current is DealDetailsLoaded,
      builder: (context, state) {
        if (state is! DealDetailsLoaded) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFD9D9D9),
                  ),
                  width: double.infinity,
                  height: 10,
                ),
                FractionallySizedBox(
                  widthFactor: state.progress,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.deepGreen,
                    ),
                    height: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'progress: ${(state.progress * 100).toStringAsFixed(0)}%',
              style: TextStyles.font16Regular.copyWith(color: AppColors.secondaryOpacity50),
            ),
          ],
        );
      },
    );
  }
}
