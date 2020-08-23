import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';
@JsonSerializable()
class User extends Object{
  String userId;
  String name;
  String surName;
  String email;
  String password;
  String accessToken;
  List<String> posts;
  User(this.userId, this.name, this.surName, this.email, this.password, this.accessToken, this.posts);
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}



