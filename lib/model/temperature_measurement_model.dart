import 'package:aquatracking/model/measurement_model.dart';

class TemperatureMeasurementModel implements MeasurementModel {
  @override
  String id;
  @override
  double value;
  @override
  DateTime measuredAt;

  TemperatureMeasurementModel({
    required this.id,
    required this.value,
    required this.measuredAt,
  });

  factory TemperatureMeasurementModel.fromJson(Map<String, dynamic> json) => TemperatureMeasurementModel(
    id: json["id"],
    value: json["temperature"].toDouble(),
    measuredAt: DateTime.parse(json["measuredAt"]),
  );
}