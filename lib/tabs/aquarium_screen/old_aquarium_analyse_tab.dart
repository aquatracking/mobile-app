import 'package:aquatracking/component/line_metric_chart.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/utils/globals.dart';
import 'package:flutter/material.dart';

class AquariumAnalyseTab extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumAnalyseTab({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MeasurementSettingsModel>>(
      stream: aquarium.measurementSettingsBloc.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data != null) {
          if(snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune mesures disponibles'));
          } else {
            snapshot.data!.sort((a, b) => a.order.compareTo(b.order));
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    for(final setting in snapshot.data!)
                      if(setting.visible) LineMetricChart(aquarium: aquarium, measurementSettings: setting),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}