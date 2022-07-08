import 'package:flutter/material.dart';
import 'base_input.dart';

/// Specialized input for numbers, implementation of our base input
class NumberInput extends StatelessWidget {
  final String label;
  final String? defaultValue;
  final IconData? icon;
  final void Function(String) onChanged;

  const NumberInput({Key? key, required this.label, this.defaultValue, this.icon, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      label: label,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      icon: icon,
      defaultValue: defaultValue,
    );
  }

}