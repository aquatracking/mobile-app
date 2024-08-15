// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementSubscriptionModel _$MeasurementSubscriptionModelFromJson(
        Map<String, dynamic> json) =>
    MeasurementSubscriptionModel(
      biotopeId: json['biotopeId'] as String,
      order: (json['order'] as num).toInt(),
      min: json['min'] as num?,
      max: json['max'] as num?,
      measurementType: MeasurementTypeModel.fromJson(
          json['measurementType'] as Map<String, dynamic>),
      lastMeasurement: json['lastMeasurement'] == null
          ? null
          : MeasurementModel.fromJson(
              json['lastMeasurement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeasurementSubscriptionModelToJson(
        MeasurementSubscriptionModel instance) =>
    <String, dynamic>{
      'biotopeId': instance.biotopeId,
      'order': instance.order,
      'min': instance.min,
      'max': instance.max,
      'measurementType': instance.measurementType,
      'lastMeasurement': instance.lastMeasurement,
    };
