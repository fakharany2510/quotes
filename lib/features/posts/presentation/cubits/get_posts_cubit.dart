import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/posts/domain/entities/posts_entity.dart';

import '../../../../core/utils/app_strings.dart';
import '../../domain/use_cases/get_posts_use_case.dart';
import 'get_posts_state.dart';


class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsUseCase getPostsUseCase;
  GetPostsCubit({required this.getPostsUseCase}) : super(GetPostsInitial());
  GetPostsCubit get(context) => BlocProvider.of(context);


  Future<void> getAllPosts()async{
    emit(GetPostsLoading());
    Either<Failure , List<PostsEntity>>  response = await getPostsUseCase();
    emit(
      response.fold(
              (failure) => GetPostsError(msg:_mapFailureToMsg(failure)),
              (PostsEntity) => GetPostsLoaded(posts:PostsEntity ))
    );
  }
  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;

      default:
        return AppStrings.unExpectedFailure;
    }
  }


}
