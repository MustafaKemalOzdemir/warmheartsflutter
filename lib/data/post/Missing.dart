import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/post/Address.dart';
import 'package:warm_hearts_flutter/data/post/Animal.dart';
part 'Missing.g.dart';

@JsonSerializable()
class Missing extends Object{
  String ownerId;
  String postId;
  Animal animal;
  String date;
  String missingDate;
  bool collar;
  Address address;
  Missing(this.date, this.address, this.animal, this.collar, this.missingDate, this.ownerId, this.postId);
  factory Missing.fromJson(Map<String, dynamic> json) => _$MissingFromJson(json);
}