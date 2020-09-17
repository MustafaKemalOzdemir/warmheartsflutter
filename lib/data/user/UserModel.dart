import 'package:json_annotation/json_annotation.dart';
import 'package:warm_hearts_flutter/data/user/User.dart';
part 'UserModel.g.dart';

@JsonSerializable()
class UserModel extends Object{
  bool success;
  String message;
  String token;
  User user;
  UserModel(this.success, this.message, this.token, this.user);
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

}