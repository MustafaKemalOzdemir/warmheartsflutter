// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatingResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatingResponse _$MatingResponseFromJson(Map<String, dynamic> json) {
  return MatingResponse(
    json['Success'] as bool,
    json['message'] as String,
    (json['matings'] as List)
        ?.map((e) =>
            e == null ? null : Mating.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MatingResponseToJson(MatingResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'message': instance.message,
      'matings': instance.matings,
    };
