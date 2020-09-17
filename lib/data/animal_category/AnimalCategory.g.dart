// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnimalCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalCategory _$AnimalCategoryFromJson(Map<String, dynamic> json) {
  return AnimalCategory(
    json['type'] as String,
    (json['races'] as List)
        ?.map((e) =>
            e == null ? null : AnimalRace.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AnimalCategoryToJson(AnimalCategory instance) =>
    <String, dynamic>{
      'type': instance.type,
      'races': instance.races,
    };
