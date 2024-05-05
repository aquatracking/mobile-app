import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aquarium_model.g.dart';

@immutable
@JsonSerializable()
class AquariumModel extends Equatable {
  const AquariumModel({
    required this.id,
    required this.name,
    required this.description,
    required this.startedDate,
    this.imageUrl,
    this.archiveDate,
    this.volume,
    this.salt,
  });

  final String id;
  final String name;
  final String description;
  final String startedDate;
  final String? imageUrl;
  final String? archiveDate;
  final int? volume;
  final bool? salt;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        startedDate,
        imageUrl,
        archiveDate,
        volume,
        salt,
      ];

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
      _$AquariumFromJson(json);

  Map<String, dynamic> toJson() => _$AquariumToJson(this);
}
