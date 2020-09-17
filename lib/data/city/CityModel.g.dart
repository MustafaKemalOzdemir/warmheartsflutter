// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CityModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    (json['CITIES'] as List)
        ?.map((e) =>
            e == null ? null : CityItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'CITIES': instance.cities,
    };
