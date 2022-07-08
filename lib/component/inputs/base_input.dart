import 'package:flutter/material.dart';

/// Base input used across the app with specialized implementation for each input type
class BaseInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final String? defaultValue;
  final IconData? icon;
  final bool obscureText;
  final void Function(String) onChanged;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const BaseInput({Key? key, required this.label, required this.keyboardType, this.defaultValue, this.icon, this.obscureText = false, required this.onChanged, this.minLines, this.maxLines, this.maxLength, this.focusNode, this.controller}) : super(key: key);

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
      ),
      onChanged: onChanged,
    );
  }

}