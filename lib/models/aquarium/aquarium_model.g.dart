// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aquarium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AquariumModel _$AquariumFromJson(Map<String, dynamic> json) => AquariumModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      startedDate: json['startedDate'] as String,
      imageUrl: json['imageUrl'] as String?,
      archiveDate: json['archiveDate'] as String?,
      volume: (json['volume'] as num?)?.toInt(),
      salt: json['salt'] as bool?,
    );

Map<String, dynamic> _$AquariumToJson(AquariumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startedDate': instance.startedDate,
      'imageUrl': instance.imageUrl,
      'archiveDate': instance.archiveDate,
      'volume': instance.volume,
      'salt': instance.salt,
    };
