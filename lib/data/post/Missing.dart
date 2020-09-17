import 'package:json_annotation/json_annotation.dart';
part 'Missing.g.dart';

@JsonSerializable()
class Missing extends Object{
  String ownerId;
  String postId;
  String date;
  String title;
  String description;
  @JsonKey(name: 'animalName')
  String name;
  int castrated;
  String type;
  String race;
  String gender;
  String age;
  String source;
  int regularVaccine;
  String city;
  String town;
  String addressDetail;
  num latitude;
  num longitude;
  String missingDate;
  int collar;
  List<String> images;
  Missing(this.ownerId, this.postId, this.date, this.title, this.description, this.name, this.castrated, this.type, this.race, this.gender, this.age, this.source, this.regularVaccine,
      this.city, this.town, this.addressDetail, this.latitude, this.longitude, this.missingDate, this.collar, this.images);
  factory Missing.fromJson(Map<String, dynamic> json) => _$MissingFromJson(json);
}