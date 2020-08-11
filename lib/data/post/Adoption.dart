import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Address.dart';
import 'package:warm_hearts_flutter/data/post/Animal.dart';
part 'Adoption.g.dart';

@JsonSerializable()
class Adoption extends Object{
  String ownerId;
  String postId;
  String date;
  Animal animal;
  Address address;
  Adoption(this.ownerId, this.postId, this.date, this.animal, this.address);
  factory Adoption.fromJson(Map<String, dynamic> json) => _$AdoptionFromJson(json);
}