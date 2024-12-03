import 'package:flutter/material.dart';

class GenericTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final bool? enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  const GenericTextFormField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.readOnly,
    this.enabled,
    this.controller,
    this.focusNode,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  @override
  State<GenericTextFormField> createState() => _GenericTextFormFieldState();
}

class _GenericTextFormFieldState extends State<GenericTextFormField> {
  late bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        hintText: widget.hint,
        suffixIcon: widget.suffixIcon != null
            ? Icon(widget.suffixIcon)
            : widget.keyboardType == TextInputType.visiblePassword
                ? IconButton(
                    icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => obscureText = !obscureText),
                  )
                : null,
        enabled: widget.enabled ?? true,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        focusColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      obscureText: obscureText,
      readOnly: widget.readOnly ?? false,
      focusNode: widget.focusNode,
    );
  }
}
