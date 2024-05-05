import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terrarium_model.g.dart';

@immutable
@JsonSerializable()
class TerrariumModel extends BiotopeModel {
  const TerrariumModel({
    required super.id,
    required super.name,
    required super.description,
    required super.startedDate,
    super.imageUrl,
    super.archiveDate,
    super.volume,
    this.wet,
  });

  final bool? wet;

  @override
  List<Object?> get props => [
        super.props,
        wet,
      ];

  @override
  TerrariumModel copyWith({
    String? id,
    String? name,
    String? description,
    String? startedDate,
    String? imageUrl,
    String? archiveDate,
    int? volume,
    bool? wet,
  }) {
    return TerrariumModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startedDate: startedDate ?? this.startedDate,
      imageUrl: imageUrl ?? this.imageUrl,
      archiveDate: archiveDate ?? this.archiveDate,
      volume: volume ?? this.volume,
      wet: wet ?? this.wet,
    );
  }

  static TerrariumModel fromJson(Map<String, dynamic> json) =>
      _$TerrariumModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TerrariumModelToJson(this);
}
