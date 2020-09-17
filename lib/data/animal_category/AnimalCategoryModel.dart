import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/animal_category/AnimalCategory.dart';
part 'AnimalCategoryModel.g.dart';

@JsonSerializable()
class AnimalCategoryModel extends Object{
  List<AnimalCategory> animalData;
  AnimalCategoryModel(this.animalData);
  factory AnimalCategoryModel.fromJson(Map<String, dynamic> json) => _$AnimalCategoryModelFromJson(json);
}