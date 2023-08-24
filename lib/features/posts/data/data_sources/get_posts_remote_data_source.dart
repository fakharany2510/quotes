import 'package:dartz/dartz.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/utils/extensions.dart';
import 'package:quotes/features/posts/data/models/posts_model.dart';

abstract class GetPostsRemoteDataSource{
  Future<List<PostsModel>> getAllPosts();
}
class GetPostsRemoteDataSourceImpl implements GetPostsRemoteDataSource{
  final ApiConsumer apiConsumer;
  GetPostsRemoteDataSourceImpl({required this.apiConsumer});

  @override
    Future<List<PostsModel>> getAllPosts() async{
    dynamic response = await apiConsumer.get(EndPoints.getAllPosts);
    return List<PostsModel>.from((response as List)
        .map((e) => PostsModel.fromJson(e)));
  }

}