import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class StandardSelectableDropdown extends StatefulWidget {
  final List<String> items;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool readOnly;
  final bool showRequiredIndicator;
  final Function(String?)? onChanged;
  final bool isRequired = false;

  const StandardSelectableDropdown({
    super.key,
    this.readOnly = false,
    required this.items,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.showRequiredIndicator = false,
    required this.onChanged,
  });

  @override
  State<StandardSelectableDropdown> createState() => _StandardSelectableDropdownState();
}

class _StandardSelectableDropdownState extends State<StandardSelectableDropdown> {
  late String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant StandardSelectableDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        selectedValue = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildLabel(),
        DropdownButtonFormField<String>(
          alignment: AlignmentDirectional.centerStart,
          hint: Text(widget.hintText ?? '', style: TextStyles.font16Regular.copyWith(color: AppColors.hintColor)),
          value: selectedValue,
          style: TextStyles.font16Regular,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          focusColor: AppColors.white,
          decoration: InputDecoration(
            suffixIconColor: AppColors.iconColor,
            border: _generalBorder(),
            enabledBorder: _generalBorder(),
            focusedBorder: _generalBorder(),
            errorBorder: _generalBorder(AppColors.red),
            hintStyle: TextStyles.font16Regular.copyWith(color: AppColors.hintColor),
          ),
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: widget.readOnly
              ? null
              : (value) {
                  setState(() {
                    selectedValue = value;
                    widget.onChanged?.call(value);
                  });
                },
          validator: widget.isRequired
              ? (value) {
                  if (value == null || !widget.items.contains(value)) {
                    return 'Please select a valid option.';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  InputBorder _generalBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: color ?? AppColors.secondaryOpacity13),
    );
  }

  Widget _buildLabel() {
    if (widget.labelText == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          style: TextStyles.font16Regular,
          children: [
            TextSpan(text: widget.labelText, style: TextStyles.font16Regular),
            TextSpan(
              text: widget.showRequiredIndicator ? ' *' : '',
              style: TextStyles.font16Regular.copyWith(color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }
}
