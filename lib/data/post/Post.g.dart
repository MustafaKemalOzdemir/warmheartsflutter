// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['postId'] as String,
    json['title'] as String,
    json['description'] as String,
    json['ownerId'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'description': instance.description,
      'ownerId': instance.ownerId,
    };
