import 'package:autro_app/constants/assets.dart';
import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/core/widgets/show_icon_button.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/screens/customer_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../core/theme/text_styles.dart';
import '../../../../bloc/customers_list/customers_list_bloc.dart';

class CustomerListTile extends StatelessWidget {
  const CustomerListTile({super.key, required this.customerEntity});
  final CustomerEntity customerEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(width: 12),
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
          const SizedBox(width: 12),
          Expanded(
            flex: 4,
            child: Text(
              customerEntity.businessDetails,
              style: TextStyles.font16Regular.copyWith(
                color: AppColors.secondaryOpacity50,
              ),
            ),
          ),
          const SizedBox(width: 16),
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
                        _launchURL(context, customerEntity.website);
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
                  NavUtil.push(
                      context,
                      CustomerInformationScreen(
                        customer: customerEntity,
                        formType: FormType.edit,
                      ));
                }),
                const SizedBox(width: 8),
                ShowIconButton(
                  onPressed: () {
                    NavUtil.push(
                        context,
                        CustomerInformationScreen(
                          customer: customerEntity,
                          formType: FormType.view,
                        ));
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
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    if (await canLaunchUrlString(url)) {
      await launchUrl(Uri.parse(url));
    } else {
      if (!context.mounted) return;
      DialogUtil.showErrorSnackBar(context, 'Could not launch $url');
    }
  }
}
