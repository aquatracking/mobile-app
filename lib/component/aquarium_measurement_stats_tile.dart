import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AquariumDetailStatsTile extends StatelessWidget {
  final MeasurementSettingsModel measurementSettings;
  final String stats;
  final MeasurementModel? measurement;
  final bool showDate;
  final String? warningDesignation;

  const AquariumDetailStatsTile({Key? key, required this.measurementSettings, required this.stats, required this.measurement, this.showDate = false, this.warningDesignation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? warning;
    IconData icon = Icons.warning_rounded;
    ColorScheme warningScheme = ColorScheme.fromSeed(seedColor: Colors.orangeAccent, brightness: Theme.of(context).brightness);

    if(warningDesignation != null && measurement != null) {
      if(measurementSettings.maxValue != null && measurementSettings.maxValue! < measurement!.value) {
        warning = '$warningDesignation &&&& est supérieure de ${(measurement!.value - measurementSettings.maxValue!).toStringAsFixed(2)}${measurementSettings.type.unit} à la valeur maximale';
        icon = Icons.trending_up_rounded;
      } else if(measurementSettings.minValue != null && measurementSettings.minValue! > measurement!.value) {
        warning = '$warningDesignation &&&& est inférieure de ${(measurementSettings.minValue! - measurement!.value).toStringAsFixed(2)}${measurementSettings.type.unit} à la valeur minimale';
        icon = Icons.trending_down_rounded;
      }

      if(warning != null) {
        String metric = measurementSettings.type.name;
        if(metric.startsWith(RegExp('[aeiouy]', caseSensitive: false))) {
          metric = 'd\'$metric';
        } else {
          metric = 'de $metric';
        }
        warning = warning.replaceAll('&&&&', metric).toLowerCase();
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stats,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              ),
              Text(
                (measurement != null) ? '${measurement!.value.toStringAsFixed(2)}${measurementSettings.type.unit}${(showDate) ? ' - ${DateFormat('dd/MM/yyyy HH:mm', 'fr').format(measurement!.measuredAt)}' : ''}' : 'N/A',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              ),
            ],
          ),
          const Spacer(),
          Visibility(
            visible: warning != null,
            child: IconButton(
              icon: Icon(icon, color: warningScheme.primary),
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Attention'),
                      content: Text(warning!),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}