import 'package:aquatracking/blocs/temperature_measurements_bloc.dart';
import 'package:aquatracking/component/line_metric_chart.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:flutter/material.dart';

class AquariumAnalyseTab extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumAnalyseTab({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TemperatureMeasurementsBloc temperatureMeasurementsBloc = TemperatureMeasurementsBloc();
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              LineMetricChart(aquariumId: aquarium.id ,measurementsBloc: temperatureMeasurementsBloc, metric: 'Température', unit: '°C', defaultFetchMode: 1),
            ],
          ),
        )
    );
  }
}