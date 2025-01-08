import 'dart:async';

import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StandardInput extends StatefulWidget {
  const StandardInput({
    super.key,
    this.controller,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.fillColor,
    this.iconSuffix,
    this.hintText,
    this.suffix,
    this.labelText,
    this.initialValue,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.obscureText = false,
    this.withBorder = true,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.expands = false,
    this.autocorrect = false,
    this.delayOnChangeCallback = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxHeight,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.prefix,
    this.iconPrefix,
    this.autoFillHints,
    this.textInputAction,
    this.inputFormatters,
    this.radius = 6,
    this.showRequiredIndecator = false,
  });

  final TextEditingController? controller;
  final bool showRequiredIndecator;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Widget? iconSuffix;
  final Widget? iconPrefix;
  final Widget? suffix;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool withBorder;
  final bool autofocus;
  final int minLines;
  final bool enabled;
  final bool readOnly;
  final bool expands;
  final bool autocorrect;
  final bool delayOnChangeCallback;
  final int maxLines;
  final double? maxHeight;
  final double radius;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefix;
  final List<String>? autoFillHints;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<StandardInput> createState() => _StandardInputState();
}

class _StandardInputState extends State<StandardInput> {
  Timer? _debounce;

  _onSearchChanged(String query) {
    // check whether the callback should be triggered immediately or delay
    if (!widget.delayOnChangeCallback) {
      if (widget.onChanged != null) {
        widget.onChanged!(query);
      }
      return;
    }
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (widget.onChanged != null) {
        widget.onChanged!(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = Theme.of(context).inputDecorationTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        TextFormField(
          decoration: InputDecoration(
            iconColor: AppColors.iconColor,
            constraints: BoxConstraints(maxHeight: widget.maxHeight ?? 90.0),
            enabled: widget.enabled,
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(16),
            suffixIcon: widget.iconSuffix,
            prefixIconColor: AppColors.iconColor,
            suffix: widget.suffix,
            prefixIcon: widget.iconPrefix,
            prefix: widget.prefix,
            hintText: widget.hintText,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            border: widget.withBorder
                ? inputDecoration.border
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            errorBorder: widget.withBorder
                ? inputDecoration.errorBorder
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            enabledBorder: widget.withBorder
                ? inputDecoration.enabledBorder
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            focusedErrorBorder: widget.withBorder
                ? inputDecoration.focusedErrorBorder
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            focusedBorder: widget.withBorder
                ? inputDecoration.focusedBorder
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            disabledBorder: widget.withBorder
                ? inputDecoration.disabledBorder
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide.none,
                  ),
            suffixIconColor: AppColors.iconColor,
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,

            // fillColor: !widget.enabled ? ITMCoreColors.grayLight : widget.fillColor,
            // filled: widget.fillColor != null || !widget.enabled,
          ),
          focusNode: widget.focusNode,
          controller: widget.controller,
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: _onSearchChanged,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          maxLines: widget.maxLines < widget.minLines ? widget.minLines : widget.maxLines,
          minLines: widget.minLines,
          validator: widget.validator,
          expands: widget.expands,
          readOnly: widget.readOnly,
          autocorrect: widget.autocorrect,
          textAlignVertical: widget.expands ? TextAlignVertical.top : TextAlignVertical.center,
          autofocus: widget.autofocus,
          initialValue: widget.controller != null ? null : widget.initialValue,
          autofillHints: widget.autoFillHints,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          // so the text color remains black even if the input is disabled we are modifying the fill color
          // as behaviour for the disabled state
          style: !widget.enabled
              ? null
              : Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color.fromRGBO(30, 31, 43, 1)),
        ),
      ],
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
              text: widget.showRequiredIndecator ? ' *' : '',
              style: TextStyles.font16Regular.copyWith(color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }
}
