// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Adoption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adoption _$AdoptionFromJson(Map<String, dynamic> json) {
  return Adoption(
    json['ownerId'] as String,
    json['postId'] as String,
    json['date'] as String,
    json['title'] as String,
    json['description'] as String,
    json['name'] as String,
    json['castrated'] as int,
    json['type'] as String,
    json['race'] as String,
    json['gender'] as String,
    json['age'] as String,
    json['source'] as String,
    json['regularVaccine'] as int,
    json['city'] as String,
    json['town'] as String,
    json['addressDetail'] as String,
    json['latitude'] as num,
    json['longitude'] as num,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AdoptionToJson(Adoption instance) => <String, dynamic>{
      'ownerId': instance.ownerId,
      'postId': instance.postId,
      'date': instance.date,
      'title': instance.title,
      'description': instance.description,
      'name': instance.name,
      'castrated': instance.castrated,
      'type': instance.type,
      'race': instance.race,
      'gender': instance.gender,
      'age': instance.age,
      'source': instance.source,
      'regularVaccine': instance.regularVaccine,
      'city': instance.city,
      'town': instance.town,
      'addressDetail': instance.addressDetail,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'images': instance.images,
    };
