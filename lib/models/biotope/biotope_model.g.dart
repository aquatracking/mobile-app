// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biotope_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiotopeModel _$BiotopeModelFromJson(Map<String, dynamic> json) => BiotopeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      startedDate: json['startedDate'] as String,
      imageUrl: json['imageUrl'] as String?,
      archiveDate: json['archiveDate'] as String?,
      volume: (json['volume'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BiotopeModelToJson(BiotopeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startedDate': instance.startedDate,
      'imageUrl': instance.imageUrl,
      'archiveDate': instance.archiveDate,
      'volume': instance.volume,
    };
