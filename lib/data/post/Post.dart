import 'package:json_annotation/json_annotation.dart';
part 'Post.g.dart';
@JsonSerializable()
class Post extends Object{
  String postId;
  String title;
  String description;
  String ownerId;
  Post(this.postId, this.title, this.description, this.ownerId);
  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

}