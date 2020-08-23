// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatingModel _$MatingModelFromJson(Map<String, dynamic> json) {
  return MatingModel(
    json['success'] as bool,
    json['message'] as String,
    json['mating'] == null
        ? null
        : Mating.fromJson(json['mating'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MatingModelToJson(MatingModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'mating': instance.mating,
    };
