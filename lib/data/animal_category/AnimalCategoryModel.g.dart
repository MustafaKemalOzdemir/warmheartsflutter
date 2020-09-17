// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnimalCategoryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalCategoryModel _$AnimalCategoryModelFromJson(Map<String, dynamic> json) {
  return AnimalCategoryModel(
    (json['animalData'] as List)
        ?.map((e) => e == null
            ? null
            : AnimalCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AnimalCategoryModelToJson(
        AnimalCategoryModel instance) =>
    <String, dynamic>{
      'animalData': instance.animalData,
    };
