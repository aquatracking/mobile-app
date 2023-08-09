import 'package:aquatracking/component/measurement_settings_card.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:flutter/material.dart';

class AquariumMeasurementSettingsScreen extends StatefulWidget {
  final AquariumModel aquarium;

  const AquariumMeasurementSettingsScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  State<AquariumMeasurementSettingsScreen> createState() => _AquariumMeasurementSettingsScreenState();
}

class _AquariumMeasurementSettingsScreenState extends State<AquariumMeasurementSettingsScreen> {
  late List<MeasurementSettingsModel> measurementSettings;

  @override
  void initState() {
    measurementSettings = widget.aquarium.measurementSettingsBloc.getMeasurementSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Préférences de mesure'),
        actions: [
          TextButton(
            onPressed: () => {
              widget.aquarium.measurementSettingsBloc.update(measurementSettings),
              Navigator.pop(context)
            },
            child: const Text('Enregistrer'),
          )
        ],
      ),
      body: (measurementSettings.isEmpty) ?
        const Center(
          child: Text('Aucune préférence de mesure'),
        ) :
        Column(
          children: [
            Expanded(
              child: ReorderableListView(
                children: measurementSettings.map((setting) => MeasurementSettingsCard(key : Key(setting.id), measurementSettings: setting)).toList(),
                onReorder: (int start, int current) {
                  for(int i = 0; i < measurementSettings.length; i++) {
                    if(measurementSettings[i].order == start) {
                      measurementSettings[i].order = current;
                      if(current > start) measurementSettings[i].order--;
                    } else {
                      if(current > start && i < current && i > start) {
                        measurementSettings[i].order--;
                      } else if(current < start && i >= current && i < start) {
                        measurementSettings[i].order++;
                      }
                    }
                  }

                  setState(() {
                    measurementSettings.sort((a, b) => a.order.compareTo(b.order));
                  });
                },
              ),
            ),
          ],
        ),
    );
  }
}