import 'dart:typed_data';

import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/unit8list_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_terrarium_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CreateTerrariumModel extends CreateBiotopeModel {
  bool wet;

  CreateTerrariumModel({
    super.name = "",
    super.description = "",
    super.startedDate,
    super.volume,
    super.image,
    this.wet = false,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        wet,
      ];

  @override
  CreateTerrariumModel copyWith({
    String? name,
    String? description,
    DateTime? startedDate,
    double? volume,
    Uint8List? image,
    bool? wet,
  }) {
    return CreateTerrariumModel(
      name: name ?? this.name,
      description: description ?? this.description,
      startedDate: startedDate ?? this.startedDate,
      volume: volume ?? this.volume,
      image: image ?? this.image,
      wet: wet ?? this.wet,
    );
  }

  static CreateTerrariumModel fromJson(Map<String, dynamic> json) =>
      _$CreateTerrariumModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateTerrariumModelToJson(this);
}
