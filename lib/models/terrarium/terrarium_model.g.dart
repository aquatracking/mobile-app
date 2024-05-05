// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terrarium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerrariumModel _$TerrariumModelFromJson(Map<String, dynamic> json) =>
    TerrariumModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      startedDate: json['startedDate'] as String,
      imageUrl: json['imageUrl'] as String?,
      archiveDate: json['archiveDate'] as String?,
      volume: (json['volume'] as num?)?.toInt(),
      wet: json['wet'] as bool?,
    );

Map<String, dynamic> _$TerrariumModelToJson(TerrariumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startedDate': instance.startedDate,
      'imageUrl': instance.imageUrl,
      'archiveDate': instance.archiveDate,
      'volume': instance.volume,
      'wet': instance.wet,
    };
