import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Adoption.dart';
part 'AdoptionModel.g.dart';

@JsonSerializable()
class AdoptionModel extends Object{
  bool success;
  String message;
  Adoption adoption;
  AdoptionModel(this.success, this.message, this.adoption);
  factory AdoptionModel.fromJson(Map<String, dynamic> json) => _$AdoptionModelFromJson(json);
}