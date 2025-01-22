import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/utils/link_util.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/core/widgets/show_icon_button.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/screens/customer_details_screen.dart';
import 'package:autro_app/features/customers/presentation/screens/customer_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/text_styles.dart';
import '../bloc/customers_list/customers_list_bloc.dart';

class CustomerListTile extends StatelessWidget {
  const CustomerListTile({super.key, required this.customerEntity});
  final CustomerEntity customerEntity;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavUtil.push(context, CustomerDetailsScreen(customerEntity: customerEntity));
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                customerEntity.name,
                style: TextStyles.font16Regular,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    customerEntity.city,
                    style: TextStyles.font16Regular,
                  ),
                  Text(
                    customerEntity.country,
                    style: TextStyles.font16Regular.copyWith(
                      color: AppColors.secondaryOpacity50,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 3,
              child: Text(
                customerEntity.businessDetails,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 4,
              child: Text(
                customerEntity.primaryContact,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Text(
                '1',
                textAlign: TextAlign.center,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Opacity(
                opacity: customerEntity.website.isNotEmpty ? 1 : 0.5,
                child: IconButton(
                  onPressed: customerEntity.website.isEmpty
                      ? null
                      : () {
                          LinkUtil.openLink(context, customerEntity.website);
                        },
                  icon: SvgPicture.asset(Assets.iconsInternet),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(onPressed: () async {
                    await NavUtil.push(
                        context,
                        CustomerFormScreen(
                          customer: customerEntity,
                          formType: FormType.edit,
                        ));
                  }),
                  const SizedBox(width: 8),
                  ShowIconButton(
                    onPressed: () {
                      NavUtil.push(context, CustomerDetailsScreen(customerEntity: customerEntity));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context.read<CustomersListBloc>().add(
                            DeleteCustomerEvent(
                              customerId: customerEntity.id,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
