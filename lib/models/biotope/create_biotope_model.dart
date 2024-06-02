import 'dart:typed_data';

import 'package:aquatracking/unit8list_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_biotope_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CreateBiotopeModel extends Equatable {
  CreateBiotopeModel({
    required this.name,
    required this.description,
    this.startedDate,
    this.volume,
    this.image,
  });

  String name;
  String description;
  DateTime? startedDate;
  double? volume;

  @Uint8ListConverter()
  Uint8List? image;

  @override
  List<Object?> get props => [
        name,
        description,
        startedDate,
        volume,
        image,
      ];

  CreateBiotopeModel copyWith({
    String? name,
    String? description,
    DateTime? startedDate,
    double? volume,
    Uint8List? image,
  }) {
    return CreateBiotopeModel(
      name: name ?? this.name,
      description: description ?? this.description,
      startedDate: startedDate ?? this.startedDate,
      volume: volume ?? this.volume,
      image: image ?? this.image,
    );
  }

  static CreateBiotopeModel fromJson(Map<String, dynamic> json) =>
      _$CreateBiotopeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBiotopeModelToJson(this);
}
