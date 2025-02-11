import 'package:autro_app/core/constants/assets.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';

import '../../../../../core/widgets/inputs/standard_input.dart';
import '../../../bills/domin/dtos/bill_filter_dto.dart';

class BillsFilterDialog extends StatefulWidget {
  const BillsFilterDialog._(this.filterDto);
  final BillsFilterDto? filterDto;

  static Future<BillsFilterDto?> show(BuildContext context, {required BillsFilterDto? filter}) async {
    final result = await DialogUtil.showStandardDialog(
      showCloseBtnWhenNotDismissible: true,
      context: context,
      child: BillsFilterDialog._(filter),
    ) as BillsFilterDto?;

    return result;
  }

  @override
  State createState() => _BillsFilterDialogState();
}

class _BillsFilterDialogState extends State<BillsFilterDialog> {
  late TextEditingController fromDateController;
  late TextEditingController toDateController;

  @override
  void initState() {
    super.initState();
    fromDateController = TextEditingController(text: widget.filterDto?.fromDate?.formattedDateYYYYMMDD);
    toDateController = TextEditingController(text: widget.filterDto?.toDate?.formattedDateYYYYMMDD);
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 400,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Filter',
                style: TextStyles.font20SemiBold.copyWith(color: AppColors.secondaryOpacity75),
              ),
              const SizedBox(height: 20),
              // From Date Picker
              StandardInput(
                readOnly: true,
                onTap: () => _pickDate(context, fromDateController),
                controller: fromDateController,
                labelText: 'Start Date',
                hintText: 'e.g mm/dd/yyyy',
                iconSuffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(Assets.iconsDate),
                ),
              ),
              const SizedBox(height: 20),
              // To Date Picker
              StandardInput(
                readOnly: true,
                onTap: () => _pickDate(context, toDateController),
                controller: toDateController,
                labelText: 'End Date',
                hintText: 'e.g mm/dd/yyyy',
                iconSuffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(Assets.iconsDate),
                ),
              ),
              const Spacer(),
              // Action buttons
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      NavUtil.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        fromDateController.clear();
                        toDateController.clear();
                      });
                    },
                    child: const Text('Reset'),
                  ),
                  TextButton(
                    onPressed: () {
                      final fromDate = DateTime.tryParse(fromDateController.text);
                      final toDate = DateTime.tryParse(toDateController.text);

                      if (fromDate != null || toDate != null) {
                        context
                            .read<BillsListBloc>()
                            .add(ApplyFilter(filterDto: BillsFilterDto(fromDate: fromDate, toDate: toDate)));
                      } else {
                        context.read<BillsListBloc>().add(ResetFilter());
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
