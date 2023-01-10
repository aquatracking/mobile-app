import 'package:aquatracking/component/inputs/date_and_time_input.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:flutter/material.dart';

MeasurementTypeModel? _measurementTypeSelected;
String _value = "";
DateTime _date = DateTime.now();
AquariumsService _aquariumsService = AquariumsService();

class NewMeasurementDialog extends StatefulWidget {
  final AquariumModel aquarium;

  const NewMeasurementDialog({Key? key, required this.aquarium}) : super(key: key);

  @override
  State<NewMeasurementDialog> createState() => _NewMeasurementDialogState();
}

class _NewMeasurementDialogState extends State<NewMeasurementDialog> {
  @override
  void initState() {
    _measurementTypeSelected = null;
    _value = "";
    _date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nouvelle mesure'),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<List<MeasurementSettingsModel>>(
              stream: widget.aquarium.measurementSettingsBloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var measurementSettings = snapshot.data!.toList();
                  measurementSettings.sort((a, b) => a.order.compareTo(b.order));
                  measurementSettings.removeWhere((element) => !element.visible);

                  return DropdownButtonFormField<MeasurementTypeModel>(
                    items: [
                      for (final measurementSetting in measurementSettings)
                        DropdownMenuItem(
                          value: measurementSetting.type,
                          child: Text(measurementSetting.type.name),
                        ),
                    ],
                    isExpanded: true,
                    decoration: const InputDecoration(
                      label: Text('Type de mesure'),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _measurementTypeSelected = value;
                      });
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Valeur',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DateAndTimeInput(
              onChanged: (value) {
                setState(() {
                  _date = DateTime.parse(value);
                });
              },
              defaultValue: _date.toIso8601String(),
              firstDate: DateTime(0),
              lastDate: DateTime.now(),
            ),
          ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Ajouter'),
          onPressed: () {
            if(_measurementTypeSelected != null && _value.isNotEmpty) {
              _aquariumsService.addMeasurement(
                  widget.aquarium,
                  _measurementTypeSelected!,
                  _value,
                  _date
              );
              widget.aquarium.measurementSettingsBloc.fetchMeasurementSettings();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}