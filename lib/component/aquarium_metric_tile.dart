import 'package:aquatracking/blocs/last_measurement_bloc.dart';
import 'package:aquatracking/blocs/passing_time_bloc.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:aquatracking/screen/aquarium_measurement_screen.dart';
import 'package:flutter/material.dart';

class AquariumMetricTile extends StatefulWidget {
  final MeasurementSettingsModel metric;
  final AquariumModel aquarium;

  late final LastMeasurementBloc lastMeasurementBloc;

  AquariumMetricTile({Key? key, required this.metric, required this.aquarium}) : super(key: key) {
    lastMeasurementBloc = LastMeasurementBloc(aquarium: aquarium, measurementType: metric.type);
  }

  @override
  State<AquariumMetricTile> createState() => _AquariumMetricTileState();
}

class _AquariumMetricTileState extends State<AquariumMetricTile> {
  PassingTimeBloc? passingTimeBloc;

  @override
  void dispose() {
    widget.lastMeasurementBloc.dispose();
    if(passingTimeBloc != null) passingTimeBloc!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.data_usage_rounded;

    switch(widget.metric.type.code) {
      case 'TEMPERATURE':
        icon = Icons.thermostat_rounded;
        break;
      case 'PH':
        icon = Icons.science_rounded;
        break;
      case 'NO2':
        icon = Icons.eco_rounded;
        break;
      case 'NO3':
        icon = Icons.eco_rounded;
        break;
      case 'NH4':
        icon = Icons.eco_rounded;
        break;
    }

    return StreamBuilder<MeasurementModel?>(
        stream: widget.lastMeasurementBloc.stream,
        builder: (context, snapshot) {
          MeasurementModel? measurement;
          bool loading = false;
          if(!snapshot.connectionState.name.contains('active')) {
            loading = true;
          } else if(snapshot.data != null) {
            measurement = snapshot.data;
          }

          Color colorSeed = Colors.blue;
          if(measurement != null) {
            if(widget.metric.maxValue != null || widget.metric.minValue != null) {
              if((widget.metric.maxValue != null && measurement.value > widget.metric.maxValue!) || (widget.metric.minValue != null && measurement.value < widget.metric.minValue!)) {
                colorSeed = Colors.redAccent;
              } else {
                colorSeed = Colors.greenAccent;
              }
            }
          }
          ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: colorSeed, brightness: Theme.of(context).brightness);

          Widget valueWidget = const Text('Aucune donnée');
          if(loading) {
            valueWidget = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                SizedBox(width: 8),
                Text('Chargement...'),
              ],
            );
          } else if(measurement != null) {
            passingTimeBloc = PassingTimeBloc(time: measurement.measuredAt);
            valueWidget = StreamBuilder<String>(
              stream: passingTimeBloc!.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Text(
                    measurement!.value.toStringAsFixed(2) + widget.metric.type.unit
                        + ' (il y a ' + snapshot.data! + ')',
                  );
                } else {
                  return const Text('Chargement...');
                }
              }
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            child: Card(
              color: colorScheme.surface,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Icon(icon, size: 40, color: colorScheme.primary),
                title: Text(widget.metric.type.name),
                subtitle: valueWidget,
                trailing: const Icon(Icons.arrow_forward_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AquariumMeasurementScreen(aquarium: widget.aquarium, metric: widget.metric),
                    ),
                  );
                },
              ),
            ),
          );
        }
    );
  }
}