// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_aquarium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAquariumModel _$CreateAquariumModelFromJson(Map<String, dynamic> json) =>
    CreateAquariumModel(
      name: json['name'] as String,
      description: json['description'] as String,
      startedDate: json['startedDate'] == null
          ? null
          : DateTime.parse(json['startedDate'] as String),
      volume: (json['volume'] as num?)?.toDouble(),
      salt: json['salt'] as bool? ?? false,
    );

Map<String, dynamic> _$CreateAquariumModelToJson(
        CreateAquariumModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'startedDate': instance.startedDate?.toIso8601String(),
      'volume': instance.volume,
      'salt': instance.salt,
    };
