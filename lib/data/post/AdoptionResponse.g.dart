// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdoptionResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdoptionResponse _$AdoptionResponseFromJson(Map<String, dynamic> json) {
  return AdoptionResponse(
    json['Success'] as bool,
    json['message'] as String,
    (json['adoptions'] as List)
        ?.map((e) =>
            e == null ? null : Adoption.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AdoptionResponseToJson(AdoptionResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'message': instance.message,
      'adoptions': instance.adoptions,
    };
