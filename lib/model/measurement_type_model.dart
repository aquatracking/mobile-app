class MeasurementTypeModel {
  String code;
  String name;
  String unit;

  MeasurementTypeModel({
    required this.code,
    required this.name,
    required this.unit,
  });

  factory MeasurementTypeModel.fromJson(Map<String, dynamic> json) => MeasurementTypeModel(
    code: json["code"],
    name: json["name"],
    unit: json["unit"],
  );
}