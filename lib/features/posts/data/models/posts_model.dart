import 'package:equatable/equatable.dart';
import 'package:quotes/features/posts/domain/entities/posts_entity.dart';

class PostsModel extends PostsEntity{
  const PostsModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body
});
  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  // Map<String, dynamic> toJson() => {
  //   "userId": userId,
  //   "id": id,
  //   "title": title,
  //   "body": body,
  // };

}