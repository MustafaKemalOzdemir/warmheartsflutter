
import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/city/DistrictItem.dart';
part 'CityItem.g.dart';

@JsonSerializable()
class CityItem extends Object{
  @JsonKey(name: 'SEHIRID')
  int cityId;
  @JsonKey(name: 'SEHIR')
  String cityName;
  @JsonKey(name: 'ILCELER')
  List<DistrictItem> districts;
  CityItem(this.cityId, this.cityName, this.districts);
  factory CityItem.fromJson(Map<String, dynamic> json) =>
      _$CityItemFromJson(json);

}