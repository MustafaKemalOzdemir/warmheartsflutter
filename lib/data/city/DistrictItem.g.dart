// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DistrictItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictItem _$DistrictItemFromJson(Map<String, dynamic> json) {
  return DistrictItem(
    json['ILCEID'] as int,
    json['ILCE'] as String,
  );
}

Map<String, dynamic> _$DistrictItemToJson(DistrictItem instance) =>
    <String, dynamic>{
      'ILCEID': instance.districtId,
      'ILCE': instance.districtName,
    };
