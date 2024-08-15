import 'package:aquatracking/models/measurement/measurement_model.dart';
import 'package:aquatracking/models/measurementType/measurement_type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'measurement_subscription_model.g.dart';

@immutable
@JsonSerializable()
class MeasurementSubscriptionModel extends Equatable {
  const MeasurementSubscriptionModel({
    required this.biotopeId,
    required this.order,
    this.min,
    this.max,
    required this.measurementType,
    this.lastMeasurement,
  });

  final String biotopeId;
  final int order;
  final num? min;
  final num? max;
  final MeasurementTypeModel measurementType;
  final MeasurementModel? lastMeasurement;

  @override
  List<Object?> get props => [
        biotopeId,
        order,
        min,
        max,
        measurementType,
        lastMeasurement,
      ];

  MeasurementSubscriptionModel copyWith({
    String? biotopeId,
    int? order,
    num? min,
    num? max,
    MeasurementTypeModel? measurementType,
    MeasurementModel? lastMeasurement,
  }) {
    return MeasurementSubscriptionModel(
      biotopeId: biotopeId ?? this.biotopeId,
      order: order ?? this.order,
      min: min ?? this.min,
      max: max ?? this.max,
      measurementType: measurementType ?? this.measurementType,
      lastMeasurement: lastMeasurement ?? this.lastMeasurement,
    );
  }

  static MeasurementSubscriptionModel fromJson(Map<String, dynamic> json) =>
      _$MeasurementSubscriptionModelFromJson(json);
}
