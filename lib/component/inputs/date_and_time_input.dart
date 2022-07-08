import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';


/// Date input widget, implementation of our base input widget
class DateAndTimeInput extends StatelessWidget {
  final String label;
  final String? defaultValue;
  final IconData? icon;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(String) onChanged;

  const DateAndTimeInput({Key? key, required this.label, this.defaultValue, this.icon, required this.onChanged, required this.firstDate, required this.lastDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMMM yyyy',
      locale: const Locale("fr", "FR"),
      firstDate: firstDate,
      lastDate: lastDate,
      timePickerEntryModeInput: true,
      dateLabelText: 'Date',
      timeLabelText: 'Heure',
      icon: icon != null ? Icon(icon) : null,
      initialValue: defaultValue,
      onChanged: onChanged,
    );
  }

}