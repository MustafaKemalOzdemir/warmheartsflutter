// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdoptionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdoptionModel _$AdoptionModelFromJson(Map<String, dynamic> json) {
  return AdoptionModel(
    json['success'] as bool,
    json['message'] as String,
    json['adoption'] == null
        ? null
        : Adoption.fromJson(json['adoption'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AdoptionModelToJson(AdoptionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'adoption': instance.adoption,
    };
