import 'package:json_annotation/json_annotation.dart';
part 'Address.g.dart';

@JsonSerializable()
class Address extends Object{
  String addressId;
  String city;
  String town;
  String addressDetail;
  Address(this.addressId, this.city, this.town, this.addressDetail);
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

}