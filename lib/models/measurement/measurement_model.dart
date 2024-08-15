import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'measurement_model.g.dart';

@immutable
@JsonSerializable()
class MeasurementModel extends Equatable {
  const MeasurementModel({
    required this.id,
    required this.measurementTypeCode,
    required this.value,
    required this.measuredAt,
  });

  final String id;
  final String measurementTypeCode;
  final num value;
  final String measuredAt;

  @override
  List<Object?> get props => [
        id,
        measurementTypeCode,
        value,
        measuredAt,
      ];

  MeasurementModel copyWith({
    String? id,
    String? measurementTypeCode,
    num? value,
    String? measuredAt,
  }) {
    return MeasurementModel(
      id: id ?? this.id,
      measurementTypeCode: measurementTypeCode ?? this.measurementTypeCode,
      value: value ?? this.value,
      measuredAt: measuredAt ?? this.measuredAt,
    );
  }

  static MeasurementModel fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementModelToJson(this);
}
