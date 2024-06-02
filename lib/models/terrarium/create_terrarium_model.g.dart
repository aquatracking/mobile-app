// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_terrarium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTerrariumModel _$CreateTerrariumModelFromJson(
        Map<String, dynamic> json) =>
    CreateTerrariumModel(
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      startedDate: json['startedDate'] == null
          ? null
          : DateTime.parse(json['startedDate'] as String),
      volume: (json['volume'] as num?)?.toDouble(),
      image: const Uint8ListConverter().fromJson(json['image'] as List<int>?),
      wet: json['wet'] as bool? ?? false,
    );

Map<String, dynamic> _$CreateTerrariumModelToJson(
        CreateTerrariumModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'startedDate': instance.startedDate?.toIso8601String(),
      'volume': instance.volume,
      'image': const Uint8ListConverter().toJson(instance.image),
      'wet': instance.wet,
    };
