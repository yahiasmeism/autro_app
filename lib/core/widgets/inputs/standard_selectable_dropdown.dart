import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';

class StandardSelectableDropdownField extends StatefulWidget {
  final List<String> items;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool readOnly;
  final bool showRequiredIndicator;
  final TextEditingController? controller;
  const StandardSelectableDropdownField({
    super.key,
    this.readOnly = false,
    required this.items,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.showRequiredIndicator = false,
    this.controller,
  });

  @override
  State<StandardSelectableDropdownField> createState() => _StandardSelectableDropDownState();
}

class _StandardSelectableDropDownState extends State<StandardSelectableDropdownField> {
  final SuggestionsBoxController _dropdownSearchFieldController = SuggestionsBoxController();
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) textEditingController.text = widget.initialValue!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildLabel(),
        IgnorePointer(
          ignoring: widget.readOnly,
          child: DropDownSearchFormField(
              enabled: !widget.readOnly,
              loadingBuilder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
              validator: (value) {
                if (!widget.items.contains(value)) return 'Please select a valid option.';
                return null;
              },
              debounceDuration: Duration.zero,
              suggestionsCallback: (pattern) {
                return getSuggestions(pattern);
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: textEditingController,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  border: _generalBorder(),
                  enabledBorder: _generalBorder(),
                  focusedBorder: _generalBorder(),
                  errorBorder: _generalBorder(AppColors.red),
                  hintText: widget.hintText,
                  hintStyle: TextStyles.font16Regular.copyWith(color: AppColors.hintColor),
                ),
              ),
              itemBuilder: (context, String suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              itemSeparatorBuilder: (context, index) {
                return const Divider(height: 0);
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (String suggestion) {
                textEditingController.text = suggestion;
              },
              suggestionsBoxController: _dropdownSearchFieldController,
              suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                color: AppColors.scaffoldBackgroundColor,
                elevation: 1,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              )),
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

  _buildLabel() {
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

  List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(widget.items);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
