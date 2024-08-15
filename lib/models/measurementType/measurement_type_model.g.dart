// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementTypeModel _$MeasurementTypeModelFromJson(
        Map<String, dynamic> json) =>
    MeasurementTypeModel(
      code: json['code'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MeasurementTypeModelToJson(
        MeasurementTypeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'unit': instance.unit,
      'description': instance.description,
    };
