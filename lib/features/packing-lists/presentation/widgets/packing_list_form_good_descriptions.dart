import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/packing-lists/domin/dtos/packing_list_description_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/standard_selection_dropdown.dart';
import '../bloc/packing_list_form/packing_list_form_cubit.dart';

class PackingListFormGoodDescriptions extends StatelessWidget {
  const PackingListFormGoodDescriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardCard(
      padding: const EdgeInsets.all(0),
      title: 'Good Descriptions',
      child: BlocBuilder<PackingListFormCubit, PackingListFormState>(
        buildWhen: (previous, current) => current is PackingListFormLoaded,
        builder: (context, state) {
          if (state is! PackingListFormLoaded) return const SizedBox.shrink();
          return Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.goodDescriptionsList.length,
                separatorBuilder: (context, index) => Divider(
                  height: 20,
                  color: AppColors.secondaryOpacity25,
                ),
                itemBuilder: (context, index) => _buildGoodDescription(
                  context,
                  state.goodDescriptionsList[index],
                ),
              ),
              if (state.goodDescriptionsList.isNotEmpty) Divider(height: 24, color: AppColors.secondaryOpacity25),
              _buildGoodDescriptionInputs(context, state),
              if (state.goodDescriptionsList.isNotEmpty)
                Column(
                  children: [
                    Divider(height: 24, color: AppColors.secondaryOpacity25),
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

  Widget _buildGoodDescription(BuildContext context, PackingListDescriptionDto dto) {
    final type = dto.type?.capitalized;
    final cubit = context.read<PackingListFormCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: StandardInput(
                  labelText: 'Container Number',
                  controller: TextEditingController(text: dto.containerNumber),
                  hintText: 'enter container number',
                  onChanged: (p0) {
                    cubit.updateGoodDescription(dto.copyWith(containerNumber: p0));
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  hintText: 'e.g percento',
                  labelText: 'percento',
                  controller: TextEditingController(text: dto.percento.toString()),
                  onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(percento: p0)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  hintText: 'e.g 3',
                  labelText: 'Items count',
                  controller: TextEditingController(text: dto.itemsCount.toString()),
                  onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(itemsCount: int.tryParse(p0) ?? 0)),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              const SizedBox(width: 65),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StandardInput(
                  // readOnly: true,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                  hintText: 'e.g 19.6',
                  labelText: 'Container Empty Weight(MT)',
                  onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(emptyContainerWeight: double.tryParse(p0) ?? 0)),
                  controller: TextEditingController(text: dto.emptyContainerWeight.toStringAsFixed(2)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardSelectableDropdown(
                  initialValue: type,
                  // readOnly: true,
                  items: const ['Bales', 'Loose', 'Bults', 'Rolls', 'Packing', 'Lot'],
                  labelText: 'Packing',
                  onChanged: (p0) => cubit.updateGoodDescription(dto.copyWith(type: p0)),
                  hintText: 'Type',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      cubit.updateGoodDescription(dto.copyWith(date: selectedDate));
                    }
                  },
                  readOnly: true,
                  iconSuffix: const Icon(Icons.calendar_month),
                  hintText: 'e.g yyyy-mm-dd',
                  controller: TextEditingController(text: dto.date.formattedDateYYYYMMDD),
                  labelText: 'Date',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  readOnly: true,
                  label: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: 'VGM ', style: TextStyles.font16Regular),
                      TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
                    ]),
                  ),
                  controller: TextEditingController(text: dto.vgm.toStringAsFixed(2)),
                  hintText: 'e.g 80',
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 40,
                child: _buildDeleteButton(context, dto),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoodDescriptionInputs(BuildContext context, PackingListFormLoaded state) {
    final bloc = context.read<PackingListFormCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: StandardInput(
                  controller: bloc.containerNumberController,
                  labelText: 'Container Number',
                  hintText: 'e.g 123',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  controller: bloc.percentoController,
                  labelText: 'Percento',
                  hintText: 'e.g percento',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  hintText: 'e.g 20',
                  controller: bloc.itemsCountController,
                  labelText: 'Items count',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  controller: bloc.weightController,
                  labelText: 'Weight(MT)',
                  keyboardType: TextInputType.number,
                  hintText: 'e.g 3',
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}$'))],
                ),
              ),
              const SizedBox(width: 65),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StandardInput(
                  controller: bloc.emptyContainerWeightController,
                  labelText: 'Container Empty Weight(MT)',
                  keyboardType: TextInputType.number,
                  hintText: 'e.g 80€',
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}$'))],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardSelectableDropdown(
                  hintText: 'Type',
                  initialValue: bloc.typeController.text.isNotEmpty ? bloc.typeController.text : null,
                  items: const ['Bales', 'Loose', 'Bults', 'Rolls', 'Packing', 'Lot'],
                  onChanged: (p0) {
                    bloc.typeController.text = p0 ?? '';
                  },
                  labelText: 'Packing',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      bloc.dateController.text = selectedDate.formattedDateYYYYMMDD;
                    }
                  },
                  readOnly: true,
                  iconSuffix: const Icon(Icons.calendar_month),
                  hintText: 'e.g yyyy-mm-dd',
                  controller: bloc.dateController,
                  labelText: 'Date',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  readOnly: true,
                  controller: bloc.vgmController,
                  label: Text.rich(
                    TextSpan(children: [
                      TextSpan(text: 'VGM ', style: TextStyles.font16Regular),
                      TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
                    ]),
                  ),
                  hintText: 'e.g 80€',
                ),
              ),
              const SizedBox(width: 20),
              _buildAddButton(state, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context, PackingListDescriptionDto dto) {
    return InkWell(
      onTap: () => context.read<PackingListFormCubit>().removeGoodDescription(dto),
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

  Widget _buildAddButton(PackingListFormLoaded state, BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: state.addGoodDescriptionEnabled
          ? () {
              context.read<PackingListFormCubit>().addGoodDescription();
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

  Widget _buildGoodDesciriptionSummary(PackingListFormLoaded state) {
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
            initialValue: 'Spain',
            hintText: 'Spain',
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
            controller: TextEditingController(text: state.goodDescriptionsList.length.toString()),
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
          // const SizedBox(width: 20),
          // Expanded(
          //     child: StandardInput(
          //   readOnly: true,
          //   label: Text.rich(
          //     TextSpan(children: [
          //       TextSpan(text: 'Total Amount ', style: TextStyles.font16Regular),
          //       TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
          //     ]),
          //   ),
          //   controller: TextEditingController(text: state.allTotalAmount.toStringAsFixed(2)),
          //   // readOnly: true,
          // )),
        ],
      ),
    );
  }
}
