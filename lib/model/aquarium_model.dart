import 'dart:typed_data';

import 'package:aquatracking/blocs/measurement_settings_bloc.dart';
import 'package:aquatracking/service/aquariums_service.dart';

class AquariumModel {
  String id;
  String name;
  String description;
  DateTime startedDate;
  int volume;
  String imageUrl;
  Uint8List? image;
  bool salt;
  late MeasurementSettingsBloc measurementSettingsBloc;

  AquariumModel({
    required this.id,
    required this.name,
    this.description = "",
    required this.startedDate,
    required this.volume,
    this.imageUrl = "",
    this.image,
    this.salt = false,
  }) {
    measurementSettingsBloc = MeasurementSettingsBloc(aquarium: this);
    AquariumsService().getImage(this);
  }

  factory AquariumModel.fromJson(Map<String, dynamic> json) => AquariumModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    startedDate: DateTime.parse(json["startedDate"]),
    volume: json["volume"],
    imageUrl: "",
    image: (json["image"] != null) ? Uint8List.fromList(List<int>.from(json["image"]["data"])) : null,
    salt: json["salt"],
  );
}