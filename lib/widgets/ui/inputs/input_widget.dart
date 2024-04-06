import 'package:flutter/material.dart';

/// Base input used across the app with specialized implementation for each input type
class InputWidget extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final String? defaultValue;
  final IconData? icon;
  final IconData? prefixIcon;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  const InputWidget({
    super.key,
    required this.label,
    required this.keyboardType,
    this.defaultValue,
    this.icon,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.focusNode,
    this.controller,
    this.autofillHints,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      initialValue: defaultValue,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        icon: (icon != null) ? Icon(icon) : null,
        prefixIcon: (prefixIcon != null) ? Icon(prefixIcon) : null,
        border: const OutlineInputBorder(),
      ),
      autofillHints: autofillHints,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
