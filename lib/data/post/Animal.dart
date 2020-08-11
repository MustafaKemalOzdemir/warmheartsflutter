import 'package:json_annotation/json_annotation.dart';
part 'Animal.g.dart';

@JsonSerializable()
class Animal extends Object{
  String ownerId;
  String animalId;
  String type;
  String race;
  int gender;
  String age;
  List<String> images;
  int source;
  bool regularVaccine;
  Animal(this.ownerId, this.animalId, this.type, this.race, this.images, this.gender, this.age, this.regularVaccine, this.source);
  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

}