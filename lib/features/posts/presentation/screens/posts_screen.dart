import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/posts/presentation/cubits/get_posts_cubit.dart';
import 'package:quotes/features/posts/presentation/cubits/get_posts_state.dart';
import 'package:quotes/injection_container.dart' as di;

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>GetPostsCubit(getPostsUseCase:di.sl())..getAllPosts(),
    child: BlocConsumer<GetPostsCubit , GetPostsState>(
      builder: (context, state) {
        if(state is GetPostsLoaded){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              title: Text('Posts'),
              centerTitle: true,
            ),
            body: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        Text(state.posts[index].title),
                        Text(state.posts[index].body),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10,);
                },
                itemCount: state.posts.length),
          );
        }else if(state is GetPostsError){
        return Scaffold(
          body: Center(child: Text(state.msg,style: const TextStyle(
            color: Colors.red
          ),)),
        );
        }else{
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      listener: (context, state) {

      },
    ),
    );
  }
}
