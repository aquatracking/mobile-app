import 'package:aquatracking/model/measurement_type_model.dart';

class MeasurementSettingsModel {
  String id;
  String aquariumId;
  MeasurementTypeModel type;
  bool visible;
  int order;
  int defaultMode;
  double? minValue;
  double? maxValue;
  bool mailAlert;
  bool notificationAlert;

  MeasurementSettingsModel({
    required this.id,
    required this.aquariumId,
    required this.type,
    required this.visible,
    required this.order,
    required this.defaultMode,
    this.minValue,
    this.maxValue,
    required this.mailAlert,
    required this.notificationAlert,
  });

  factory MeasurementSettingsModel.fromJson(Map<String, dynamic> json) => MeasurementSettingsModel(
    id: json["id"],
    aquariumId: json["aquariumId"],
    type: MeasurementTypeModel.fromJson(json["type"]),
    visible: json["visible"],
    order: json["order"],
    defaultMode: json["defaultMode"],
    minValue: (json["minValue"] != null) ? json["minValue"].toDouble() : null,
    maxValue: (json["maxValue"] != null) ? json["maxValue"].toDouble() : null,
    mailAlert: json["mailAlert"],
    notificationAlert: json["notificationAlert"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "aquariumId": aquariumId,
    "type": type.toJson(),
    "visible": visible,
    "order": order,
    "defaultMode": defaultMode,
    "minValue": minValue,
    "maxValue": maxValue,
    "mailAlert": mailAlert,
    "notificationAlert": notificationAlert,
  };
}