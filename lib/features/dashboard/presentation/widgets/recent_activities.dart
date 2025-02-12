import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/extensions/activity_type_extension.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/module_type_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/features/bills/presentation/screens/bill_form_screen.dart';
import 'package:autro_app/features/customers/presentation/screens/customer_details_screen.dart';
import 'package:autro_app/features/dashboard/domin/entities/activity_entity.dart';
import 'package:autro_app/features/dashboard/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:autro_app/features/deals/presentation/screens/deal_details_screen.dart';
import 'package:autro_app/features/home/bloc/home_bloc.dart';
import 'package:autro_app/features/invoices/presentation/screens/custoemr_invoice_form_screen.dart';
import 'package:autro_app/features/invoices/presentation/screens/supplier_invoices_form_screen.dart';
import 'package:autro_app/features/packing-lists/presentation/screen/packing_list_form_screen.dart';
import 'package:autro_app/features/proformas/presentation/screens/customer_proforma_form_screen.dart';
import 'package:autro_app/features/proformas/presentation/screens/supplier_proformas_form_screen.dart';
import 'package:autro_app/features/shipping-invoices/presentation/screens/shipping_invoices_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/standard_card.dart';
import '../../../settings/presentation/widgets/update_bank_account_form.dart';
import '../../../suppliers/presentation/screens/supplier_details_screen.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key, required this.state});
  final DashboardLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: TextStyles.font20SemiBold.copyWith(color: AppColors.secondary),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildRecentActivityCard(context, state.latest10Activity[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: state.latest10Activity.length,
        ),
      ],
    );
  }

  _buildRecentActivityCard(BuildContext context, ActivityEntity activity) {
    return StandardCard(
      padding: const EdgeInsets.all(16),
      title: null,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: activity.type.str,
                      style: TextStyles.font16Regular.copyWith(
                        color: activity.type.color,
                      ),
                    ),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: activity.module.str,
                      style: TextStyles.font16Regular,
                    ),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: "(${moduleTitle(activity)})",
                      style: TextStyles.font16SemiBold,
                    ),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: "by ${activity.byUser.name}",
                      style: TextStyles.font16Regular,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                activity.createdAt.formattedDateMMMDDYWithTime,
                style: TextStyles.font14Regular.copyWith(
                  color: AppColors.secondaryOpacity50,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (activity.type == ActivityType.create || activity.type == ActivityType.update)
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              onTap: () => onActivityTap(context, activity),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(Assets.iconsEye, width: 24),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  String moduleTitle(ActivityEntity activity) {
    if (activity.title != null && activity.title!.isNotEmpty) {
      return activity.title!;
    }
    return '';
  }

  onActivityTap(BuildContext context, ActivityEntity activity) {
    switch (activity.module) {
      case ModuleType.deal:
        NavUtil.push(context, DealDetailsScreen(dealId: activity.moduleId));
        break;
      case ModuleType.customer:
        NavUtil.push(context, CustomerDetailsScreen(customerId: activity.moduleId));

        break;
      case ModuleType.supplier:
        NavUtil.push(context, SupplierDetailsScreen(id: activity.moduleId));
        break;
      case ModuleType.customerInvoice:
        NavUtil.push(context, CustomerInvoiceFormScreen(formType: FormType.edit, invoiceId: activity.moduleId));
        break;
      case ModuleType.customerProforma:
        NavUtil.push(context, ProformaFormScreen(formType: FormType.edit, proformaId: activity.moduleId));
        break;
      case ModuleType.supplierInvoice:
        NavUtil.push(context, SupplierInvoiceFormScreen(formType: FormType.edit, supplierInvoiceId: activity.moduleId));
        break;
      case ModuleType.supplierProforma:
        NavUtil.push(context, SupplierProformaFormScreen(formType: FormType.edit, supplierProformaId: activity.moduleId));
        break;
      case ModuleType.shippingInvoice:
        NavUtil.push(context, ShippingInvoiceFormScreen(formType: FormType.edit, id: activity.moduleId));
        break;
      case ModuleType.bill:
        NavUtil.push(context, BillFormScreen(formType: FormType.edit, billId: activity.moduleId));
        break;
      case ModuleType.company:
        context.read<HomeBloc>().add(const NavigationItemTappedEvent(item: MenuItemType.settings));
        break;
      case ModuleType.packingList:
        NavUtil.push(context, PackingListFormScreen(formType: FormType.edit, id: activity.moduleId));
        break;
      case ModuleType.bankAccount:
        NavUtil.push(context, UpdateBankAccountFormScreen(id: activity.moduleId));
        break;
      case ModuleType.user:
        break;
      case ModuleType.unknown:
        break;
    }
  }
}
