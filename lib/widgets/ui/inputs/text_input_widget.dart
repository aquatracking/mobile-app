import 'package:aquatracking/widgets/ui/inputs/input_widget.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final String? initialValue;
  final IconData? icon;
  final IconData? prefixIcon;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  const TextInputWidget({
    super.key,
    required this.label,
    this.keyboardType,
    this.initialValue,
    this.icon,
    this.prefixIcon,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.autofillHints,
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
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      icon: icon,
      prefixIcon: prefixIcon,
      defaultValue: initialValue,
      autofillHints: autofillHints,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
