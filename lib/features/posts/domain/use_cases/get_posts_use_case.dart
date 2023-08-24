import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/posts/domain/entities/posts_entity.dart';
import 'package:quotes/features/posts/domain/repositories/get_posts_repository.dart';

class GetPostsUseCase {
  final GetPostsRepository getPostsRepository;
  GetPostsUseCase({required this.getPostsRepository});

  Future<Either<Failure , List<PostsEntity>>> call() async{
    return await getPostsRepository.getAllPosts();
  }
}