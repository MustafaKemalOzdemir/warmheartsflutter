// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['addressId'] as String,
    json['city'] as String,
    json['town'] as String,
    json['addressDetail'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressId': instance.addressId,
      'city': instance.city,
      'town': instance.town,
      'addressDetail': instance.addressDetail,
    };
