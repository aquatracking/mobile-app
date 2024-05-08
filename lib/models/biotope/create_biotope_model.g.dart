// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_biotope_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBiotopeModel _$CreateBiotopeModelFromJson(Map<String, dynamic> json) =>
    CreateBiotopeModel(
      name: json['name'] as String,
      description: json['description'] as String,
      startedDate: json['startedDate'] == null
          ? null
          : DateTime.parse(json['startedDate'] as String),
      volume: (json['volume'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CreateBiotopeModelToJson(CreateBiotopeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'startedDate': instance.startedDate?.toIso8601String(),
      'volume': instance.volume,
    };
