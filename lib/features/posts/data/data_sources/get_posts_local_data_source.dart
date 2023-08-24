import '../models/posts_model.dart';

abstract class GetPostsLocalDataSource{
  Future<List<PostsModel>> getAllPosts();
}

class GetPostsLocalDataSourceImpl implements GetPostsLocalDataSource{
  @override
  Future<List<PostsModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

}