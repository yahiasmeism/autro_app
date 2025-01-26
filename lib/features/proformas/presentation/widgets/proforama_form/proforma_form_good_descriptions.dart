import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/core/widgets/standard_selection_dropdown.dart';
import 'package:autro_app/features/proformas/domin/dtos/proforma_good_description_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/cubit/proforma_form_cubit.dart';

class ProformaFormGoodDescriptions extends StatelessWidget {
  const ProformaFormGoodDescriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardCard(
      padding: const EdgeInsets.all(0),
      title: 'Good Descriptions',
      child: BlocBuilder<ProformaFormCubit, ProformaFormState>(
        buildWhen: (previous, current) => current is ProformaFormLoaded,
        builder: (context, state) {
          if (state is! ProformaFormLoaded) return const SizedBox.shrink();
          return Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.goodDescriptionsList.length,
                separatorBuilder: (context, index) => Divider(
                  height: 20,
                  color: AppColors.secondaryOpacity8,
                ),
                itemBuilder: (context, index) => _buildGoodDescription(
                  context,
                  state.goodDescriptionsList[index],
                  isLast: index == state.goodDescriptionsList.length - 1,
                ),
              ),
              if (state.goodDescriptionsList.isNotEmpty) Divider(height: 24, color: AppColors.secondaryOpacity8),
              _buildGoodDescriptionInputs(context, state),
              if (state.goodDescriptionsList.isNotEmpty)
                Column(
                  children: [
                    Divider(height: 24, color: AppColors.secondaryOpacity8),
                    _buildGoodDesciriptionSummary(state),
                  ],
                ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGoodDescription(BuildContext context, ProformaGoodDescriptionDto dto, {bool isLast = false}) {
    final cubit = context.read<ProformaFormCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: StandardInput(
              labelText: 'Description',
              controller: TextEditingController(text: dto.description),
              hintText: 'e.g PP PLASTICS',
              onChanged: (p0) {
                cubit.updateGoodDescription(dto.copyWith(description: p0));
              },
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              hintText: 'e.g 3',
              labelText: 'Containers count',
              controller: TextEditingController(text: dto.containersCount.toString()),
              onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(containersCount: int.tryParse(p0) ?? 0)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              // readOnly: true,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
              labelText: 'Weight(MT)',
              hintText: 'e.g 19.6',
              onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(weight: double.tryParse(p0) ?? 0)),
              controller: TextEditingController(text: dto.weight.toStringAsFixed(2)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              // readOnly: true,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
              hintText: 'e.g 80\$',
              labelText: 'Unit price',
              onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(unitPrice: double.tryParse(p0) ?? 0)),
              controller: TextEditingController(text: dto.unitPrice.toStringAsFixed(2)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardSelectableDropdown(
              // readOnly: true,
              items: const ['Bales', 'Loose', 'Bults', 'Rollosm', 'Packing', 'Lot'],
              labelText: 'Packing',
              onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(packing: p0)),
              hintText: 'Type',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              readOnly: true,
              label: Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'Total Value ', style: TextStyles.font16Regular),
                  TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
                ]),
              ),
              controller: TextEditingController(text: dto.totalPrice.toStringAsFixed(2)),
              hintText: 'e.g 80\$',
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 40,
            child: Visibility(
              visible: isLast,
              child: _buildDeleteButton(context, dto),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoodDescriptionInputs(BuildContext context, ProformaFormLoaded state) {
    final bloc = context.read<ProformaFormCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: StandardInput(
              controller: bloc.descriptionController,
              labelText: 'Description',
              hintText: 'e.g PP PLASTICS',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              controller: bloc.containersCountController,
              labelText: 'Containers count',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: 'e.g 3',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              hintText: 'e.g 19.6',
              controller: bloc.weightController,
              labelText: 'Weight(MT)',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}$'))],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              controller: bloc.unitPriceController,
              labelText: 'Unit Price',
              keyboardType: TextInputType.number,
              hintText: 'e.g 80\$',
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}$'))],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardSelectableDropdown(
              hintText: 'Type',
              initialValue: bloc.packingController.text.isNotEmpty ? bloc.packingController.text : null,
              items: const ['Bales', 'Loose', 'Bults', 'Rollosm', 'Packing', 'Lot'],
              onChanged: (p0) {
                bloc.packingController.text = p0 ?? '';
              },
              labelText: 'Packing',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: StandardInput(
              readOnly: true,
              controller: bloc.totalPriceController,
              label: Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'Total Value ', style: TextStyles.font16Regular),
                  TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
                ]),
              ),
              hintText: 'e.g 80\$',
            ),
          ),
          const SizedBox(width: 20),
          _buildAddButton(state, context),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context, ProformaGoodDescriptionDto dto) {
    return InkWell(
      onTap: () => context.read<ProformaFormCubit>().removeGoodDescription(dto),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
          height: 70,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.redOpacity13,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            Assets.iconsDelete,
          )),
    );
  }

  Widget _buildAddButton(ProformaFormLoaded state, BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: state.addGoodDescriptionEnabled
          ? () {
              context.read<ProformaFormCubit>().addGoodDescription();
            }
          : null,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
          width: 40,
          height: 70,
          decoration: BoxDecoration(
            color: state.addGoodDescriptionEnabled ? AppColors.primaryOpacity13 : AppColors.secondaryOpacity13,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.add,
            color: state.addGoodDescriptionEnabled ? AppColors.primary : AppColors.secondaryOpacity25,
          )),
    );
  }

  Widget _buildGoodDesciriptionSummary(ProformaFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Row(
        children: [
          Expanded(
              child: StandardInput(
            label: Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Origin of Goods ', style: TextStyles.font16Regular),
                TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
              ]),
            ),
            initialValue: 'Spin',
            hintText: 'Spin',
            readOnly: true,
          )),
          const SizedBox(width: 20),
          Expanded(
              child: StandardInput(
            readOnly: true,
            label: Text.rich(
              TextSpan(children: [
                TextSpan(text: '40ft Containers Count ', style: TextStyles.font16Regular),
                TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
              ]),
            ),
            controller: TextEditingController(text: state.allContainerCount.toString()),
          )),
          const SizedBox(width: 20),
          Expanded(
              child: StandardInput(
            readOnly: true,
            label: Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Total Weight (MT) ', style: TextStyles.font16Regular),
                TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
              ]),
            ),
            controller: TextEditingController(text: state.allWeight.toStringAsFixed(2)),
          )),
          const SizedBox(width: 20),
          Expanded(
              child: StandardInput(
            readOnly: true,
            label: Text.rich(
              TextSpan(children: [
                TextSpan(text: 'Total Amount ', style: TextStyles.font16Regular),
                TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
              ]),
            ),
            controller: TextEditingController(text: state.allTotalAmount.toStringAsFixed(2)),
            // readOnly: true,
          )),
        ],
      ),
    );
  }
}
