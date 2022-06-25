class MeasurementModel {
  String id;
  double value;
  DateTime measuredAt;

  MeasurementModel({
    required this.id,
    required this.value,
    required this.measuredAt,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) => MeasurementModel(
    id: json["id"],
    value: json["value"].toDouble(),
    measuredAt: DateTime.parse(json["measuredAt"]),
  );
}