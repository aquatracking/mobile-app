import 'package:aquatracking/models/measurement/measurement_model.dart';
import 'package:aquatracking/models/measurementSubscription/measurement_subscription_model.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/time_passed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeasurementSubscriptionTile extends StatelessWidget {
  final MeasurementSubscriptionModel measurementSubscription;

  const MeasurementSubscriptionTile({
    super.key,
    required this.measurementSubscription,
  });

  @override
  Widget build(BuildContext context) {
    MeasurementModel? measurement = measurementSubscription.lastMeasurement;

    Color colorSeed = Colors.blue;
    if (measurement != null) {
      if (measurementSubscription.max != null ||
          measurementSubscription.min != null) {
        if ((measurementSubscription.max != null &&
                measurement.value > measurementSubscription.max!) ||
            (measurementSubscription.min != null &&
                measurement.value < measurementSubscription.min!)) {
          colorSeed = Colors.redAccent;
        } else {
          colorSeed = Colors.greenAccent;
        }
      }
    }
    ColorScheme colorScheme = ColorScheme.fromSeed(
        seedColor: colorSeed, brightness: Theme.of(context).brightness);

    IconData icon = Icons.data_usage_rounded;
    switch (measurementSubscription.measurementType.code) {
      case 'TEMPE':
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

    String value = AppLocalizations.of(context)!.noData;

    if (measurement != null) {
      value = measurement.value.toString();

      value += measurementSubscription.measurementType.unit;
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: colorScheme.surface,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Icon(
            icon,
            size: 40,
            color: colorScheme.primary,
          ),
          title: Text(
            measurementSubscription.measurementType.name,
            style: AppText.subTitleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: (measurement != null)
              ? TimePassedText(
                  dateTime: DateTime.parse(measurement.measuredAt),
                  template: "$value ({value})",
                )
              : Text(value),
          trailing: const Icon(
            Icons.arrow_forward_rounded,
          ),
          onTap: () {
            // todo
          },
        ),
      ),
    );
  }
}
