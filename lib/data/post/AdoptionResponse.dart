import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Adoption.dart';
part 'AdoptionResponse.g.dart';

@JsonSerializable()
class AdoptionResponse extends Object{
  @JsonKey(name: 'Success')
  bool success;
  String message;
  List<Adoption> adoptions;
  AdoptionResponse(this.success, this.message, this.adoptions);
  factory AdoptionResponse.fromJson(Map<String, dynamic> json) => _$AdoptionResponseFromJson(json);
}