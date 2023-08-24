import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/Exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/posts/data/data_sources/get_posts_remote_data_source.dart';
import 'package:quotes/features/posts/domain/entities/posts_entity.dart';
import 'package:quotes/features/posts/domain/repositories/get_posts_repository.dart';

import '../../../../core/network/network_info.dart';

class GetPostsRepositoryImpl implements GetPostsRepository{
  final GetPostsRemoteDataSource getPostsRemoteDataSource;
  final NetWorkInfo networkInfo;
  GetPostsRepositoryImpl({required this.getPostsRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() async{
      try{
        final result = await getPostsRemoteDataSource.getAllPosts();
        return Right(result);
      }on ServerException {
        return Left(ServerFailure());
      }
    }
  }
