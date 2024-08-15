import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'measurement_type_model.g.dart';

@immutable
@JsonSerializable()
class MeasurementTypeModel extends Equatable {
  const MeasurementTypeModel({
    required this.code,
    required this.name,
    required this.unit,
    this.description,
  });

  final String code;
  final String name;
  final String unit;
  final String? description;

  @override
  List<Object?> get props => [
        code,
        name,
        unit,
        description,
      ];

  MeasurementTypeModel copyWith({
    String? code,
    String? name,
    String? unit,
    String? description,
  }) {
    return MeasurementTypeModel(
      code: code ?? this.code,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      description: description ?? this.description,
    );
  }

  static MeasurementTypeModel fromJson(Map<String, dynamic> json) =>
      _$MeasurementTypeModelFromJson(json);
}
