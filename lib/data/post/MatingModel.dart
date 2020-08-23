import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Mating.dart';
part 'MatingModel.g.dart';

@JsonSerializable()
class MatingModel extends Object{
  bool success;
  String message;
  Mating mating;
  MatingModel(this.success, this.message, this.mating);
  factory MatingModel.fromJson(Map<String, dynamic> json) => _$MatingModelFromJson(json);
}