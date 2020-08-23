// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['userId'] as String,
    json['name'] as String,
    json['surName'] as String,
    json['email'] as String,
    json['password'] as String,
    json['accessToken'] as String,
    (json['posts'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'surName': instance.surName,
      'email': instance.email,
      'password': instance.password,
      'accessToken': instance.accessToken,
      'posts': instance.posts,
    };
