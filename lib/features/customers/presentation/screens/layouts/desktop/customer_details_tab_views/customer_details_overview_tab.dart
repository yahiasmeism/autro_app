// ignore_for_file: deprecated_member_use

import 'package:autro_app/core/constants/assets.dart';

import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/extensions/primary_contact_type_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/link_util.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/buttons/delete_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/edit_outline_button.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/standard_container.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/bloc/customer_details/customer_details_cubit.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:autro_app/features/customers/presentation/screens/customer_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomerDetailsOverviewTab extends StatelessWidget {
  const CustomerDetailsOverviewTab({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
      builder: (context, state) {
        if (state is CustomerDetailsInitial) {
          return const LoadingIndicator();
        } else if (state is CustomerDetailsLoaded) {
          return _buildLoadedState(state, context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLoadedState(CustomerDetailsLoaded state, BuildContext context) {
    final customerEntity = state.customerEntity;
    return SingleChildScrollView(
      child: Column(
        children: [
          StandardContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    customerEntity.name,
                    style: TextStyles.font24SemiBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(color: AppColors.secondaryOpacity8),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailsSection(
                              title: 'Location',
                              iconPath: Assets.iconsLocation,
                              details: [
                                customerEntity.country,
                                customerEntity.city,
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildDetailsSection(
                              title: 'Phone Numbers',
                              iconPath: Assets.iconsPhone,
                              details: [
                                customerEntity.phone,
                                customerEntity.altPhone,
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildDetailsSection(
                              title: 'Business',
                              iconPath: Assets.iconsBusiness,
                              details: [
                                customerEntity.businessDetails,
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailsSection(
                              title: 'Primary Contact',
                              iconPath: Assets.iconsContactDetails,
                              details: [customerEntity.primaryContactType.str],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildDetailsSection(
                              title: 'Email',
                              iconPath: Assets.iconsEmail,
                              details: [customerEntity.email],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildWebsiteDetails(context, customerEntity),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildDetailsSection(
                              title: 'Notes About the Customer',
                              iconPath: Assets.iconsNotes,
                              details: [
                                customerEntity.notes,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTotalRevenue(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTotalDeals(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildButtonsSection(context, customerEntity),
        ],
      ),
    );
  }

  Widget _buildWebsiteDetails(BuildContext context, CustomerEntity customerEntity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWithSvgIcon(title: 'Website', iconPath: Assets.iconsInternet2),
        const SizedBox(height: 8),
        customerEntity.website.isNotEmpty
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    LinkUtil.openLink(context, customerEntity.website);
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          customerEntity.website,
                          style: TextStyles.font18Regular.copyWith(color: AppColors.primary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(Assets.iconsInternet, color: AppColors.primary),
                    ],
                  ),
                ),
              )
            : Text(
                '-',
                style: TextStyles.font18Regular.copyWith(color: AppColors.secondaryOpacity50),
              ),
      ],
    );
  }

  Widget _buildTitleWithSvgIcon({required String title, required String iconPath}) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          color: AppColors.secondaryOpacity50,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            title,
            style: TextStyles.font16Regular.copyWith(color: AppColors.secondaryOpacity50),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalDeals() {
    return StandardContainer(
      padding: const EdgeInsets.all(22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.iconsDeal),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Deals',
                style: TextStyles.font20SemiBold,
              ),
              Text(
                '5',
                style: TextStyles.font24SemiBold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRevenue() {
    return StandardContainer(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.iconsDollar),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Revenue',
                style: TextStyles.font20SemiBold,
              ),
              Text(
                '\$2342',
                style: TextStyles.font24SemiBold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection(BuildContext context, CustomerEntity customerEntity) {
    return StandardContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Spacer(),
          DeleteOutlineButton(
            onPressed: () => _onDeleteTab(context, customerEntity),
          ),
          const SizedBox(width: 16),
          EditOutlineButton(
            onPressed: () => _onUpdateTab(context, customerEntity),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection({
    required String title,
    required String iconPath,
    required List<String> details,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWithSvgIcon(title: title, iconPath: iconPath),
        const SizedBox(height: 8),
        for (var detail in details)
          detail.isNotEmpty
              ? Text(
                  detail,
                  style: TextStyles.font18Regular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  '-',
                  style: TextStyles.font18Regular.copyWith(color: AppColors.secondaryOpacity50),
                ),
      ],
    );
  }

  _onDeleteTab(BuildContext context, CustomerEntity customerEntity) async {
    final isOk = await DialogUtil.showAlertDialog(
          context,
          title: 'Delete',
          content: 'Are you sure you want to delete this item?',
        ) ??
        false;
    if (isOk) {
      if (context.mounted) {
        NavUtil.pop(context);
        context.read<CustomersListBloc>().add(DeleteCustomerEvent(customerId: customerEntity.id));
      }
    }
  }

  _onUpdateTab(BuildContext context, CustomerEntity customerEntity) async {
    final updatedCustomer = await NavUtil.push(
      context,
      CustomerFormScreen(
        formType: FormType.edit,
        customer: customerEntity,
      ),
    ) as CustomerEntity?;

    if (updatedCustomer != null) {
      if (context.mounted) {
        context.read<CustomerDetailsCubit>().updateCustomer(updatedCustomer);
      }
    }
  }
}
