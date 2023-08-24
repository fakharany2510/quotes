import 'package:dartz/dartz.dart';
import 'package:quotes/features/posts/domain/entities/posts_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/get_posts_repository.dart';

class GetCachedPostsUseCase{
  final GetPostsRepository getPostsRepository;
  GetCachedPostsUseCase({required this.getPostsRepository});

  // Future<Either<Failure , List<PostsEntity>>> call() async{
  //   return await getPostsRepository.getCachedPosts();
  // }
}