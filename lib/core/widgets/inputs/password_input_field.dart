import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final bool isConfirmPassword;

  const PasswordInputField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.isConfirmPassword = false,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return StandardInput(
      hintText: widget.isConfirmPassword ? 'Confirm Password' : 'Password',
      labelText: widget.isConfirmPassword ? 'Confirm Password' : 'Password',
      onChanged: widget.onChanged,
      keyboardType: TextInputType.visiblePassword,
      validator: ValidatorUtils.validatePassword,
      controller: widget.controller,
      suffix: IconButton(
        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => obscureText = !obscureText),
      ),
      obscureText: obscureText,
      focusNode: widget.focusNode,
    );
  }
}
