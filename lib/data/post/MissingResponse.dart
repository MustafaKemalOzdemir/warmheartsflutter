import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Missing.dart';
part 'MissingResponse.g.dart';

@JsonSerializable()
class MissingResponse extends Object{
  @JsonKey(name: 'Success')
  bool success;
  String message;
  List<Missing> misings;
  MissingResponse(this.success, this.message, this.misings);
  factory MissingResponse.fromJson(Map<String, dynamic> json) => _$MissingResponseFromJson(json);
}