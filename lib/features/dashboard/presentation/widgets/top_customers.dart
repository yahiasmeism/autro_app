import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/dashboard/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../customers/presentation/screens/customer_details_screen.dart';

class TopCustomers extends StatelessWidget {
  const TopCustomers({super.key, required this.state});
  final DashboardLoaded state;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Customers',
          style: TextStyles.font20SemiBold.copyWith(color: AppColors.secondary),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildCustomerCard(
                state.dashboard.topCustomers[index], context);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: state.dashboard.topCustomers.length,
        ),
      ],
    );
  }

  Widget _buildCustomerCard(
      CustomerEntity customerEntity, BuildContext context) {
    return StandardCard(
      padding: const EdgeInsets.all(16),
      title: null,
      child: Row(
        children: [
          /// **Customer Name & Details Section**
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerEntity.name,
                  style: TextStyles.font16SemiBold,
                  overflow: TextOverflow.ellipsis, // Truncate long names
                  maxLines: 1,
                ),
                const SizedBox(height: 14),

                /// **Total Deals**
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.iconsDeal, width: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Total Deals:',
                      style: TextStyles.font16Regular
                          .copyWith(color: AppColors.secondaryOpacity50),
                    ),
                    const SizedBox(width: 6),
                    Text('${customerEntity.dealsCount}',
                        style: TextStyles.font16Regular),
                  ],
                ),
                const SizedBox(height: 8),

                /// **Total Revenue**
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.iconsDollar, width: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Total Revenue:',
                      style: TextStyles.font16Regular
                          .copyWith(color: AppColors.secondaryOpacity50),
                    ),
                    const SizedBox(width: 6),
                    Text('${customerEntity.totalRevenue}',
                        style: TextStyles.font16Regular),
                  ],
                ),
              ],
            ),
          ),

          /// **Trailing Eye Icon (View Details)**
          IntrinsicWidth(
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    NavUtil.push(context,
                        CustomerDetailsScreen(customerId: customerEntity.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(Assets.iconsEye, width: 24),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
