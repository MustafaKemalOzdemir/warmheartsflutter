import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/animal_category/AnimalRace.dart';
part 'AnimalCategory.g.dart';

@JsonSerializable()
class AnimalCategory extends Object{
  String type;
  List<AnimalRace> races;
  AnimalCategory(this.type, this.races);
  factory AnimalCategory.fromJson(Map<String, dynamic> json) => _$AnimalCategoryFromJson(json);
}