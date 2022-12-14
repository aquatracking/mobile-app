import 'package:aquatracking/component/aquarium_metric_tile.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:aquatracking/screen/aquarium_measurement_settings_screen.dart';
import 'package:flutter/material.dart';

class AquariumAnalyseTab extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumAnalyseTab({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MeasurementSettingsModel>>(
      stream: aquarium.measurementSettingsBloc.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          List<MeasurementSettingsModel> measurementSettings = [];

          if(snapshot.data != null && snapshot.data!.isNotEmpty) {
            measurementSettings = snapshot.data!.toList();
          }

          measurementSettings.sort((a, b) => a.order.compareTo(b.order));
          measurementSettings.removeWhere((element) => element.visible == false);

          return RefreshIndicator(
            onRefresh: () async {
              await aquarium.measurementSettingsBloc.fetchMeasurementSettings();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    if(measurementSettings.isEmpty) Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Aucune donnée à afficher",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            "Vous n'avez configuré aucune donnée à afficher.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AquariumMeasurementSettingsScreen(aquarium: aquarium)));
                            },
                            child: const Text(
                              "Configurer",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    for(final setting in measurementSettings)
                      AquariumMetricTile(metric: setting, aquarium: aquarium),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}