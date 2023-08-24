import 'package:equatable/equatable.dart';
import 'package:quotes/features/posts/domain/entities/posts_entity.dart';

abstract class GetPostsState extends Equatable{
  const GetPostsState();
  @override
  List<Object?> get props =>[];
}

class GetPostsInitial extends GetPostsState {}
class GetPostsLoading extends GetPostsState {}
class GetPostsLoaded extends GetPostsState {
  final List<PostsEntity> posts;
  const GetPostsLoaded({required this.posts});
  @override
  List<Object?> get props =>[posts];
}
class GetPostsError extends GetPostsState {
final String msg;
const GetPostsError({required this.msg});
@override
List<Object?> get props =>[msg];
}


