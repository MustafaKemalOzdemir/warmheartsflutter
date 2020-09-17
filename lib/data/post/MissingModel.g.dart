// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MissingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissingModel _$MissingModelFromJson(Map<String, dynamic> json) {
  return MissingModel(
    json['success'] as bool,
    json['message'] as String,
    json['missing'] == null
        ? null
        : Missing.fromJson(json['missing'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MissingModelToJson(MissingModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'missing': instance.missing,
    };
