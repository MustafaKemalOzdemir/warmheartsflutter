// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CityItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityItem _$CityItemFromJson(Map<String, dynamic> json) {
  return CityItem(
    json['SEHIRID'] as int,
    json['SEHIR'] as String,
    (json['ILCELER'] as List)
        ?.map((e) =>
            e == null ? null : DistrictItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CityItemToJson(CityItem instance) => <String, dynamic>{
      'SEHIRID': instance.cityId,
      'SEHIR': instance.cityName,
      'ILCELER': instance.districts,
    };
