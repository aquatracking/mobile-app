// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementModel _$MeasurementModelFromJson(Map<String, dynamic> json) =>
    MeasurementModel(
      id: json['id'] as String,
      measurementTypeCode: json['measurementTypeCode'] as String,
      value: json['value'] as num,
      measuredAt: json['measuredAt'] as String,
    );

Map<String, dynamic> _$MeasurementModelToJson(MeasurementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'measurementTypeCode': instance.measurementTypeCode,
      'value': instance.value,
      'measuredAt': instance.measuredAt,
    };
