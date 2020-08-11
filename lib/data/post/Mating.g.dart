// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Mating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mating _$MatingFromJson(Map<String, dynamic> json) {
  return Mating(
    json['date'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['animal'] == null
        ? null
        : Animal.fromJson(json['animal'] as Map<String, dynamic>),
    json['heat'] as bool,
    json['ownerId'] as String,
    json['postId'] as String,
  );
}

Map<String, dynamic> _$MatingToJson(Mating instance) => <String, dynamic>{
      'ownerId': instance.ownerId,
      'postId': instance.postId,
      'date': instance.date,
      'animal': instance.animal,
      'heat': instance.heat,
      'address': instance.address,
    };
