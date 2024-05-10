import 'package:flutter/material.dart';

class SegmentedButtonWidget<T> extends FormField<T> {
  final List<SegmentedButtonWidgetChoice<T>> choices;

  SegmentedButtonWidget({
    super.key,
    required T initialValue,
    required this.choices,
    super.onSaved,
  }) : super(
          initialValue: initialValue,
          builder: (FormFieldState<T> state) {
            return SegmentedButton<T>(
              segments: [
                for (final choice in choices)
                  ButtonSegment(
                    value: choice.value,
                    label: Text(choice.label),
                  ),
              ],
              selected: {state.value ?? initialValue},
              onSelectionChanged: (value) {
                state.didChange(value.first);
              },
            );
          },
        );
}

class SegmentedButtonWidgetChoice<T> {
  final T value;
  final String label;

  const SegmentedButtonWidgetChoice({
    required this.value,
    required this.label,
  });
}
