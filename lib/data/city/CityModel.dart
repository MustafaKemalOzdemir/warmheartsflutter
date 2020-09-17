import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/city/CityItem.dart';
part 'CityModel.g.dart';

@JsonSerializable()
class CityModel extends Object{
  @JsonKey(name: 'CITIES')
  List<CityItem> cities;
  CityModel(this.cities);
  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

}