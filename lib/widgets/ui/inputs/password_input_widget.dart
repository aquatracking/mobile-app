import 'package:aquatracking/widgets/ui/inputs/input_widget.dart';
import 'package:flutter/material.dart';

class PasswordInputWidget extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final String? initialValue;
  final IconData? icon;
  final IconData? prefixIcon;
  final List<String>? autofillHints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  const PasswordInputWidget({
    super.key,
    required this.label,
    this.keyboardType,
    this.initialValue,
    this.icon,
    this.prefixIcon = Icons.lock,
    this.autofillHints,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      label: label,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      icon: icon,
      prefixIcon: prefixIcon,
      defaultValue: initialValue,
      autofillHints: autofillHints ?? const [AutofillHints.password],
      obscureText: true,
      controller: controller,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
