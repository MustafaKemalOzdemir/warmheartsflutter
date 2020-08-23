import 'package:json_annotation/json_annotation.dart';

part 'AnimalRace.g.dart';

@JsonSerializable()
class AnimalRace extends Object{
  String race;
  AnimalRace(this.race);
  factory AnimalRace.fromJson(Map<String, dynamic> json) => _$AnimalRaceFromJson(json);
}