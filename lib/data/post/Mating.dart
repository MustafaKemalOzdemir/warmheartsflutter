import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Address.dart';
import 'package:warm_hearts_flutter/data/post/Animal.dart';
part 'Mating.g.dart';

@JsonSerializable()
class Mating extends Object{
  String ownerId;
  String postId;
  String date;
  Animal animal;
  bool heat;
  Address address;
  Mating(this.date, this.address, this.animal, this.heat, this.ownerId, this.postId);
  factory Mating.fromJson(Map<String, dynamic> json) => _$MatingFromJson(json);
}