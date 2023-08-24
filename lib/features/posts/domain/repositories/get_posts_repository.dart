import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/posts/domain/entities/posts_entity.dart';

abstract class GetPostsRepository{
  Future<Either<Failure , List<PostsEntity>>> getAllPosts();
  // Future<Either<Failure , List<PostsEntity>>> getCachedPosts();
}