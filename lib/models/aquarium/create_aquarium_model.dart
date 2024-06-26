import 'dart:typed_data';

import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/unit8list_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_aquarium_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CreateAquariumModel extends CreateBiotopeModel {
  bool salt;

  CreateAquariumModel({
    super.name = "",
    super.description = "",
    super.startedDate,
    super.volume,
    super.image,
    this.salt = false,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        salt,
      ];

  @override
  CreateAquariumModel copyWith({
    String? name,
    String? description,
    DateTime? startedDate,
    double? volume,
    Uint8List? image,
    bool? salt,
  }) {
    return CreateAquariumModel(
      name: name ?? this.name,
      description: description ?? this.description,
      startedDate: startedDate ?? this.startedDate,
      volume: volume ?? this.volume,
      image: image ?? this.image,
      salt: salt ?? this.salt,
    );
  }

  static CreateAquariumModel fromJson(Map<String, dynamic> json) =>
      _$CreateAquariumModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateAquariumModelToJson(this);
}
