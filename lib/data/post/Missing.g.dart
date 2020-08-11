// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Missing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Missing _$MissingFromJson(Map<String, dynamic> json) {
  return Missing(
    json['date'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['animal'] == null
        ? null
        : Animal.fromJson(json['animal'] as Map<String, dynamic>),
    json['collar'] as bool,
    json['missingDate'] as String,
    json['ownerId'] as String,
    json['postId'] as String,
  );
}

Map<String, dynamic> _$MissingToJson(Missing instance) => <String, dynamic>{
      'ownerId': instance.ownerId,
      'postId': instance.postId,
      'animal': instance.animal,
      'date': instance.date,
      'missingDate': instance.missingDate,
      'collar': instance.collar,
      'address': instance.address,
    };
