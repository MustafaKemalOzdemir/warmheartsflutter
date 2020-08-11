// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) {
  return Animal(
    json['ownerId'] as String,
    json['animalId'] as String,
    json['type'] as String,
    json['race'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['gender'] as int,
    json['age'] as String,
    json['regularVaccine'] as bool,
    json['source'] as int,
  );
}

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'ownerId': instance.ownerId,
      'animalId': instance.animalId,
      'type': instance.type,
      'race': instance.race,
      'gender': instance.gender,
      'age': instance.age,
      'images': instance.images,
      'source': instance.source,
      'regularVaccine': instance.regularVaccine,
    };
