import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aquarium_model.g.dart';

@immutable
@JsonSerializable()
class AquariumModel extends BiotopeModel {
  const AquariumModel({
    required super.id,
    required super.name,
    required super.description,
    required super.startedDate,
    super.imageUrl,
    super.archiveDate,
    super.volume,
    this.salt,
  });

  final bool? salt;

  @override
  List<Object?> get props => [
        ...super.props,
        salt,
      ];

  @override
  AquariumModel copyWith({
    String? id,
    String? name,
    String? description,
    String? startedDate,
    String? imageUrl,
    String? archiveDate,
    int? volume,
    bool? salt,
  }) {
    return AquariumModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startedDate: startedDate ?? this.startedDate,
      imageUrl: imageUrl ?? this.imageUrl,
      archiveDate: archiveDate ?? this.archiveDate,
      volume: volume ?? this.volume,
      salt: salt ?? this.salt,
    );
  }

  static AquariumModel fromJson(Map<String, dynamic> json) =>
      _$AquariumModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AquariumModelToJson(this);
}
