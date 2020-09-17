import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Mating.dart';
part 'MatingResponse.g.dart';

@JsonSerializable()
class MatingResponse extends Object{
  @JsonKey(name: 'Success')
  bool success;
  String message;
  List<Mating> matings;
  MatingResponse(this.success, this.message, this.matings);
  factory MatingResponse.fromJson(Map<String, dynamic> json) => _$MatingResponseFromJson(json);
}