// ignore_for_file: invalid_use_of_protected_member

import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/packing-lists/domin/dtos/packing_list_controllers_dto.dart';
import 'package:autro_app/features/packing-lists/presentation/widgets/packing_list_good_description_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/standard_selection_dropdown.dart';
import '../bloc/packing_list_form/packing_list_form_cubit.dart';

class PackingListFormGoodDescriptions extends StatefulWidget {
  const PackingListFormGoodDescriptions({super.key});

  @override
  State<PackingListFormGoodDescriptions> createState() => _PackingListFormGoodDescriptionsState();
}

class _PackingListFormGoodDescriptionsState extends State<PackingListFormGoodDescriptions> {
  final TextEditingController containerNumberController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController emptyContainerWeightController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController itemsCountController = TextEditingController();
  final TextEditingController dateController = TextEditingController(text: DateTime.now().formattedDateYYYYMMDD);
  final TextEditingController percentoController = TextEditingController();
  final TextEditingController allWeightController = TextEditingController();
  double vgm = 0.0;
  @override
  void initState() {
    super.initState();
    setupControllersListeners();
  }

  setupControllersListeners() {
    for (var controller in [
      containerNumberController,
      weightController,
      emptyContainerWeightController,
      typeController,
      itemsCountController,
      dateController,
      percentoController,
    ]) {
      controller.addListener(() {
        updateVgmValue();
      });
    }
  }

  void blocListener(BuildContext context, PackingListFormState state) {
    if (state is PackingListFormLoaded) {
      updateAllWeightController();
      for (var dto in state.goodDescriptionsControllersDTOsList) {
        if (!dto.weight.hasListeners) {
          dto.weight.addListener(() => updateAllWeightController());
        }
      }
    }
  }

  updateAllWeightController() {
    final state = context.read<PackingListFormCubit>().state as PackingListFormLoaded;
    double totalWeight = 0.0;
    for (var dto in state.goodDescriptionsControllersDTOsList) {
      totalWeight += double.tryParse(dto.weight.text) ?? 0.0;
    }
    allWeightController.text = totalWeight.toString();
  }

  @override
  Widget build(BuildContext context) {
    return StandardCard(
      padding: const EdgeInsets.all(0),
      title: 'Good Descriptions',
      child: BlocConsumer<PackingListFormCubit, PackingListFormState>(
        listener: (context, state) => blocListener(context, state),
        buildWhen: (previous, current) => current is PackingListFormLoaded,
        builder: (context, state) {
          if (state is! PackingListFormLoaded) return const SizedBox.shrink();

          return Column(
            children: [
              PackingListGoodDescriptionList(
                key: UniqueKey(),
                goodDescriptionsControllersDTOsList: state.goodDescriptionsControllersDTOsList,
              ),
              if (state.goodDescriptionsDTOsList.isNotEmpty) Divider(height: 24, color: AppColors.secondaryOpacity25),
              buildGoodDescriptionInputs(state, context),
              if (state.goodDescriptionsDTOsList.isNotEmpty)
                Column(
                  children: [
                    Divider(height: 24, color: AppColors.secondaryOpacity25),
                    buildGoodDesciriptionSummary(state),
                  ],
                ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget buildGoodDescriptionInputs(PackingListFormLoaded state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: StandardInput(
                  controller: containerNumberController,
                  labelText: 'Container Number',
                  hintText: 'e.g 123',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  controller: percentoController,
                  labelText: 'Precinto',
                  hintText: 'e.g Precinto',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  hintText: 'e.g 20',
                  controller: itemsCountController,
                  labelText: 'Items count',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  controller: weightController,
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
                  controller: emptyContainerWeightController,
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
                  initialValue: typeController.text.isNotEmpty ? typeController.text : null,
                  items: const ['Bales', 'Loose', 'Bulks', 'Rolls', 'Packing', 'Lot'],
                  onChanged: (p0) {
                    typeController.text = p0 ?? '';
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
                      dateController.text = selectedDate.formattedDateYYYYMMDD;
                    }
                  },
                  readOnly: true,
                  iconSuffix: const Icon(Icons.calendar_month),
                  hintText: 'e.g yyyy-mm-dd',
                  controller: dateController,
                  labelText: 'Date',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  readOnly: true,
                  controller: TextEditingController(text: vgm.toString()),
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
              buildAddButton(state, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddButton(PackingListFormLoaded state, BuildContext context) {
    final enabledAddButton = canAdd();
    return InkWell(
      splashColor: Colors.transparent,
      onTap: enabledAddButton ? () => addNewDescription(context, state) : null,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
          width: 40,
          height: 70,
          decoration: BoxDecoration(
            color: enabledAddButton ? AppColors.primaryOpacity13 : AppColors.secondaryOpacity13,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.add,
            color: enabledAddButton ? AppColors.primary : AppColors.secondaryOpacity25,
          )),
    );
  }

  Widget buildGoodDesciriptionSummary(PackingListFormLoaded state) {
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
            controller: TextEditingController(text: state.goodDescriptionsDTOsList.length.toString()),
          )),
          const SizedBox(width: 20),
          _allWeightAutoField(state, context),
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

  bool canAdd() {
    if (containerNumberController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        emptyContainerWeightController.text.isNotEmpty &&
        typeController.text.isNotEmpty &&
        itemsCountController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        percentoController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  clearInputs() {
    containerNumberController.clear();
    weightController.clear();
    emptyContainerWeightController.clear();
    typeController.clear();
    itemsCountController.clear();
    dateController.clear();
    percentoController.clear();
  }

  void addNewDescription(BuildContext context, PackingListFormLoaded state) {
    final goodDescription = PackingListControllersDto(
      vgm: TextEditingController(text: vgm.toString()),
      uniqueKey: state.goodDescriptionsDTOsList.length.toString(),
      containerNumber: TextEditingController(text: containerNumberController.text),
      weight: TextEditingController(text: (double.tryParse(weightController.text) ?? 0.0).toString()),
      emptyContainerWeight: TextEditingController(text: (double.tryParse(emptyContainerWeightController.text) ?? 0.0).toString()),
      type: TextEditingController(text: typeController.text),
      itemsCount: TextEditingController(text: (int.tryParse(itemsCountController.text) ?? 0).toString()),
      date: TextEditingController(text: dateController.text),
      percento: TextEditingController(text: percentoController.text),
    );
    context.read<PackingListFormCubit>().addGoodDescription(goodDescription);
    clearInputs();
  }

  void updateVgmValue() {
    final weight = double.tryParse(weightController.text) ?? 0.0;
    final emptyContainerWeight = double.tryParse(emptyContainerWeightController.text) ?? 0.0;
    vgm = weight + emptyContainerWeight;
    setState(() {});
  }

  Widget _allWeightAutoField(PackingListFormLoaded state, BuildContext context) {
    blocListener(context, state);
    return Expanded(
      child: StandardInput(
        readOnly: true,
        label: Text.rich(
          TextSpan(children: [
            TextSpan(text: 'Total Weight (MT) ', style: TextStyles.font16Regular),
            TextSpan(text: 'auto', style: TextStyles.font16Regular.copyWith(color: AppColors.primary)),
          ]),
        ),
        controller: allWeightController,
      ),
    );
  }
}
