import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateInputWidget extends StatelessWidget {
  const DateInputWidget({
    super.key,
    required this.label,
    this.icon,
    this.prefixIcon,
    this.firstDate,
    this.lastDate,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  final String label;
  final IconData? icon;
  final IconData? prefixIcon;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final String? Function(DateTime?)? validator;
  final void Function(DateTime)? onChanged;
  final void Function(DateTime?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      type: DateTimePickerType.date,
      locale: Localizations.localeOf(context),
      dateMask: AppLocalizations.of(context)!.dateFormat,
      firstDate: firstDate ?? DateTime(0),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 1),
      timePickerEntryModeInput: true,
      decoration: InputDecoration(
        labelText: label,
        icon: (icon != null) ? Icon(icon) : null,
        prefixIcon: (prefixIcon != null) ? Icon(prefixIcon) : null,
        border: const OutlineInputBorder(),
      ),
      initialValue: initialValue?.toString(),
      validator: validator != null
          ? (value) => validator!(
              value != null && value.isNotEmpty ? DateTime.parse(value) : null)
          : null,
      onChanged: onChanged != null
          ? (value) => onChanged!(DateTime.parse(value))
          : null,
      onSaved: onSaved != null
          ? (value) => onSaved!(
              value != null && value.isNotEmpty ? DateTime.parse(value) : null)
          : null,
    );
  }
}
