import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_details_actions_bar.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_linear_progress.dart';
import 'package:autro_app/features/deals/presentation/widgets/deal_summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/widgets/overley_loading.dart';

class DealOverviewTab extends StatelessWidget {
  final DealDetailsLoaded state;

  const DealOverviewTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  const DealSummarySection(),
                  const SizedBox(height: 14),
                  StandardCard(
                    padding: EdgeInsets.zero,
                    title: null,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.deal.dealNumber,
                            style: TextStyles.font24SemiBold,
                          ),
                        ),
                        const Divider(height: 0),
                        Padding(
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            children: [
                              const DealLinearProgress(),
                              const SizedBox(height: 16),
                              _buildDetailItem(
                                title: 'Estimated Completion',
                                value: state.deal.etaDate?.formattedDateMMMDDY ?? '',
                                svg: Assets.iconsTime,
                              ),
                              const SizedBox(height: 32),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _buildDetailItem(
                                      title: 'Customer',
                                      value: state.deal.customer?.name ?? '',
                                      svg: Assets.iconsContactDetails,
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildDetailItem(
                                      title: 'Suppliers',
                                      value: state.deal.suppliers.map((e) => e.name).join('\n'),
                                      svg: Assets.iconsContactDetails,
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildDetailItem(
                                      title: 'Materials',
                                      value: (state.deal.customerInvoice?.goodsDescriptions != null &&
                                              state.deal.customerInvoice!.goodsDescriptions.isNotEmpty)
                                          ? state.deal.customerInvoice!.goodsDescriptions.map((e) => e.description).join(', ')
                                          : (state.deal.customerProforma?.goodsDescriptions != null &&
                                                  state.deal.customerProforma!.goodsDescriptions.isNotEmpty)
                                              ? state.deal.customerProforma!.goodsDescriptions
                                                  .map((e) => e.description)
                                                  .join(', ')
                                              : '',
                                      svg: Assets.iconsProduct,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDetailItem(
                                      title: 'Status',
                                      value: state.deal.isComplete ? 'Completed' : 'Incompleted',
                                      svg: Assets.iconsStatus,
                                      labelColor: state.deal.isComplete ? AppColors.deepGreen : AppColors.orange,
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildDetailItem(
                                      title: 'Creation Date',
                                      value: state.deal.createdAt.formattedDateMMMDDY,
                                      svg: Assets.iconsDate,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 32),
                              StandardInput(
                                enabled: state.updatedMode,
                                hintText: 'Lorem ipsum dolor sit amet consectetur',
                                controller: context.read<DealDetailsCubit>().notesController,
                                label: Row(
                                  children: [
                                    SvgPicture.asset(Assets.iconsNotes),
                                    const SizedBox(width: 8),
                                    Text('Notes About the Deal', style: TextStyles.font16Regular),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(height: 0),
                        _buildForm(context, state),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const DealDetailsActionBar(),
                ],
              ),
            ),
          ),
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  Widget _buildDetailItem({
    required String title,
    required String value,
    required String svg,
    Color? labelColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(svg),
            const SizedBox(width: 8),
            Text(title, style: TextStyles.font16Regular.copyWith(color: AppColors.secondaryOpacity50)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value.isEmpty ? 'Not set yet' : value,
          style: TextStyles.font18Regular.copyWith(
            color: value.isEmpty ? AppColors.secondaryOpacity50 : labelColor,
          ),
        ),
      ],
    );
  }

  _buildForm(BuildContext context, DealDetailsLoaded state) {
    final cubit = context.read<DealDetailsCubit>();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: StandardInput(
              readOnly: true,
              onTap: () => _pickDate(context, cubit.shippingDateController),
              controller: cubit.shippingDateController,
              enabled: state.updatedMode,
              labelText: 'Shipping Date',
              hintText: 'e.g mm/dd/yyyy',
              iconSuffix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(Assets.iconsDate),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StandardInput(
              enabled: state.updatedMode,
              readOnly: true,
              onTap: () => _pickDate(context, cubit.etaDateController),
              controller: cubit.etaDateController,
              labelText: 'ETA',
              hintText: 'e.g mm/dd/yyyy',
              iconSuffix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(Assets.iconsDate),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StandardInput(
              readOnly: true,
              enabled: state.updatedMode,
              onTap: () => _pickDate(context, cubit.deliveryDateController),
              controller: cubit.deliveryDateController,
              labelText: 'Delivery Date',
              hintText: 'e.g mm/dd/yyyy',
              iconSuffix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(Assets.iconsDate),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _pickDate(BuildContext context, TextEditingController controller) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      controller.text = selectedDate.formattedDateYYYYMMDD;
    }
  }
}
