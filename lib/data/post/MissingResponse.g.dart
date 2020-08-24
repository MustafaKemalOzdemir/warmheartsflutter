// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MissingResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissingResponse _$MissingResponseFromJson(Map<String, dynamic> json) {
  return MissingResponse(
    json['Success'] as bool,
    json['message'] as String,
    (json['misings'] as List)
        ?.map((e) =>
            e == null ? null : Missing.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MissingResponseToJson(MissingResponse instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'message': instance.message,
      'misings': instance.misings,
    };
