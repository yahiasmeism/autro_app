import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/features/packing-lists/domin/dtos/packing_list_controllers_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/standard_selection_dropdown.dart';
import '../bloc/packing_list_form/packing_list_form_cubit.dart';

class PackingListGoodDescriptionList extends StatefulWidget {
  const PackingListGoodDescriptionList({super.key, required this.goodDescriptionsControllersDTOsList});
  final List<PackingListControllersDto> goodDescriptionsControllersDTOsList;

  @override
  State<PackingListGoodDescriptionList> createState() => _PackingListGoodDescriptionListState();
}

class _PackingListGoodDescriptionListState extends State<PackingListGoodDescriptionList> {
  @override
  void initState() {
    super.initState();
    setupControllersListeners();

  }

  setupControllersListeners() {
    for (final dto in widget.goodDescriptionsControllersDTOsList) {
      dto.weight.addListener(() {
        updateVgmValue(dto);
      });
      dto.emptyContainerWeight.addListener(() {
        updateVgmValue(dto);
      });
    }
  }

  updateVgmValue(PackingListControllersDto dto) {
    final weight = double.tryParse(dto.weight.text) ?? 0.0;
    final emptyContainerWeight = double.tryParse(dto.emptyContainerWeight.text) ?? 0.0;
    if (mounted) {
      setState(() {
        dto.vgm.text = (weight + emptyContainerWeight).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.goodDescriptionsControllersDTOsList.length,
      separatorBuilder: (context, index) => Divider(
        height: 20,
        color: AppColors.secondaryOpacity25,
      ),
      itemBuilder: (context, index) => _buildGoodDescription(
        context,
        widget.goodDescriptionsControllersDTOsList[index],
      ),
    );
  }

  Widget _buildGoodDescription(BuildContext context, PackingListControllersDto dto) {
    final type = dto.type?.text.capitalized ?? '';
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
                  controller: dto.containerNumber,
                  hintText: 'enter container number',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  hintText: 'e.g precinto',
                  labelText: 'precinto',
                  controller: dto.percento,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardInput(
                  hintText: 'e.g 3',
                  labelText: 'Items count',
                  controller: dto.itemsCount,
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
                  controller: dto.weight,
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
                  controller: dto.emptyContainerWeight,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: StandardSelectableDropdown(
                  initialValue: type.isEmpty ? null : type,
                  // readOnly: true,
                  items: const ['Bales', 'Loose', 'Bulks', 'Rolls', 'Packing', 'Lot'],
                  labelText: 'Packing',
                  onChanged: (p0) {
                    dto.type?.text = p0 ?? '';
                  },
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
                      dto.date.text = selectedDate.formattedDateYYYYMMDD;
                    }
                  },
                  readOnly: true,
                  iconSuffix: const Icon(Icons.calendar_month),
                  hintText: 'e.g yyyy-mm-dd',
                  controller: dto.date,
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
                  controller: dto.vgm,
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

  Widget _buildDeleteButton(BuildContext context, PackingListControllersDto dto) {
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
}
