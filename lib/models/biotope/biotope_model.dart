import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'biotope_model.g.dart';

@immutable
@JsonSerializable()
class BiotopeModel extends Equatable {
  const BiotopeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.startedDate,
    this.imageUrl,
    this.archiveDate,
    this.volume,
  });

  final String id;
  final String name;
  final String description;
  final String startedDate;
  final String? imageUrl;
  final String? archiveDate;
  final int? volume;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        startedDate,
        imageUrl,
        archiveDate,
        volume,
      ];

  BiotopeModel copyWith({
    String? id,
    String? name,
    String? description,
    String? startedDate,
    String? imageUrl,
    String? archiveDate,
    int? volume,
  }) {
    return BiotopeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startedDate: startedDate ?? this.startedDate,
      imageUrl: imageUrl ?? this.imageUrl,
      archiveDate: archiveDate ?? this.archiveDate,
      volume: volume ?? this.volume,
    );
  }

  static BiotopeModel fromJson(Map<String, dynamic> json) =>
      _$BiotopeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BiotopeModelToJson(this);
}
