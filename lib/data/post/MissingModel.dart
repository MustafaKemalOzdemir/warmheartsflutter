import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Missing.dart';
part 'MissingModel.g.dart';

@JsonSerializable()
class MissingModel extends Object{
  bool success;
  String message;
  Missing missing;
  MissingModel(this.success, this.message, this.missing);
  factory MissingModel.fromJson(Map<String, dynamic> json) => _$MissingModelFromJson(json);
}