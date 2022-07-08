import 'package:flutter/material.dart';

import 'base_input.dart';

/// Specialized input for simple text, implementation of our base input
class TextInput extends StatelessWidget {
  final String label;
  final String? initialValue;
  final IconData? icon;
  final void Function(String) onChanged;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  const TextInput({Key? key, required this.label, this.initialValue, this.icon, required this.onChanged, this.minLines, this.maxLines, this.maxLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
        label: label,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        icon: icon,
        defaultValue: initialValue,
    );
  }
}