import 'package:json_annotation/json_annotation.dart';
part 'DistrictItem.g.dart';

@JsonSerializable()
class DistrictItem extends Object{
  @JsonKey(name: 'ILCEID')
  int districtId;
  @JsonKey(name: 'ILCE')
  String districtName;

  DistrictItem(this.districtId, this.districtName);
  factory DistrictItem.fromJson(Map<String, dynamic> json) =>
      _$DistrictItemFromJson(json);

}