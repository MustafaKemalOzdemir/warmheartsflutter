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
    json['animal'] == null
        ? null
        : Animal.fromJson(json['animal'] as Map<String, dynamic>),
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AdoptionToJson(Adoption instance) => <String, dynamic>{
      'ownerId': instance.ownerId,
      'postId': instance.postId,
      'date': instance.date,
      'animal': instance.animal,
      'address': instance.address,
    };
