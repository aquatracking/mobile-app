abstract class AbstractMeasurementModel {
  String id;
  double value;
  DateTime measuredAt;

  AbstractMeasurementModel({
    required this.id,
    required this.value,
    required this.measuredAt,
  });
}