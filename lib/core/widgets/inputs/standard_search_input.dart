import 'package:autro_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'standard_input.dart';

class StandardSearchInput extends StatefulWidget {
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
  State<StandardSearchInput> createState() => _StandardSearchInputState();
}

class _StandardSearchInputState extends State<StandardSearchInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    // Listen for text changes to toggle the clear icon
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _showClearIcon = _controller.text.isNotEmpty;
    });
  }

  void _clearText() {
    _controller.clear();
    _focusNode.unfocus();
    setState(() {
      _showClearIcon = false;
    });
    widget.onSearch(context, '');
  }

  @override
  Widget build(BuildContext context) {
    return StandardInput(
      withBorder: false,
      fillColor: AppColors.scaffoldBackgroundColor,
      onFieldSubmitted: widget.onFieldSubmitted,
      iconPrefix: const Icon(Icons.search),
      focusNode: _focusNode,
      controller: _controller,
      delayOnChangeCallback: widget.delayOnChangeCallback,
      maxHeight: 100,
      hintText: 'Search',
      onChanged: (keyword) {
        widget.onSearch(context, keyword);
      },
      iconSuffix: _showClearIcon
          ? InkWell(
              onTap: _clearText,
              child: const Icon(
                Icons.clear,
                color: AppColors.iconColor,
              ),
            )
          : null,
    );
  }
}
