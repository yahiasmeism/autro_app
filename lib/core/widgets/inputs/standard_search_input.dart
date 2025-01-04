import 'package:autro_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'standard_input.dart';

class StandardSearchInput extends StatelessWidget {
  const StandardSearchInput({
    super.key,
    required this.onSearch,
    this.delayOnChangeCallback = true,
    this.focusNode,
    this.controller,
    this.onFieldSubmitted,
  });
  final Function(BuildContext context, String keyword) onSearch;
  final bool delayOnChangeCallback;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  @override
  @override
  Widget build(BuildContext context) {
    return StandardInput(
      
      withBorder: false,
      fillColor: AppColors.scaffoldBackgroundColor,
      onFieldSubmitted: onFieldSubmitted,
      iconPrefix: const Icon(Icons.search),
      focusNode: focusNode,
      controller: controller,
      delayOnChangeCallback: delayOnChangeCallback,
      maxHeight: 100,
      hintText: 'Search',
      onChanged: (keyword) {
        onSearch(context, keyword);
      },
    );
  }
}
