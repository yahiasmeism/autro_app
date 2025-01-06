import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/utils/link_util.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/core/widgets/show_icon_button.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/text_styles.dart';

class SupplierListTile extends StatelessWidget {
  const SupplierListTile({super.key, required this.supplierEntity});
  final SupplierEntity supplierEntity;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // NavUtil.push(context, CustomerDetailsScreen(supplierEntity: supplierEntity));
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
                supplierEntity.name,
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
                    supplierEntity.city,
                    style: TextStyles.font16Regular,
                  ),
                  Text(
                    supplierEntity.country,
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
                supplierEntity.businessDetails,
                style: TextStyles.font16Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 4,
              child: Text(
                supplierEntity.primaryContact,
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
                opacity: supplierEntity.website.isNotEmpty ? 1 : 0.5,
                child: IconButton(
                  onPressed: supplierEntity.website.isEmpty
                      ? null
                      : () {
                          LinkUtil.openLink(context, supplierEntity.website);
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
                  EditIconButton(onPressed: () {
                    // NavUtil.push(
                    //     context,
                    //     CustomerFormScreen(
                    //       customer: supplierEntity,
                    //       formType: FormType.edit,
                    //     ));
                  }),
                  const SizedBox(width: 8),
                  ShowIconButton(
                    onPressed: () {
                      // NavUtil.push(context, CustomerDetailsScreen(supplierEntity: supplierEntity));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      // context.read<CustomersListBloc>().add(
                      //       DeleteCustomerEvent(
                      //         customerId: supplierEntity.id,
                      //       ),
                      //     );
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
