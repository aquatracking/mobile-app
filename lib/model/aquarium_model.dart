import 'package:aquatracking/blocs/aquarium_image_bloc.dart';
import 'package:aquatracking/blocs/measurement_settings_bloc.dart';

class AquariumModel {
  String id;
  String name;
  String description;
  DateTime startedDate;
  int volume;
  bool salt;
  late MeasurementSettingsBloc measurementSettingsBloc;
  late AquariumImageBloc aquariumImageBloc;

  AquariumModel({
    required this.id,
    required this.name,
    this.description = "",
    required this.startedDate,
    required this.volume,
    this.salt = false,
  }) {
    measurementSettingsBloc = MeasurementSettingsBloc(aquarium: this);
    aquariumImageBloc = AquariumImageBloc(aquarium: this);
  }

  factory AquariumModel.fromJson(Map<String, dynamic> json) => AquariumModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    startedDate: DateTime.parse(json["startedDate"]),
    volume: json["volume"],
    salt: json["salt"],
  );
}