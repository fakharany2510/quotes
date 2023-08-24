import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/posts/presentation/screens/posts_screen.dart';
import 'package:quotes/features/quotes_main/presentation/screens/quotes_home_screen.dart';
import 'package:quotes/features/splash/presentation/screens/splash_screen.dart';
import 'package:quotes/injection_container.dart' as di;

import '../../features/quotes_main/presentation/cubit/random_quote_cubit.dart';
class Routes{
  static const String initialRoute = '/';
  static const String randomQuotesRoute = '/randomQuotes';
  static const String posts = '/posts';
}

class AppRoutes{
  static Route? onGenerateRoute (RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context)=>const SplashScreen(),
          // BlocProvider(
          // create: (context) => di.sl<RandomQuoteCubit>(),child: const QuotesHomeScreen())
        );
      case Routes.randomQuotesRoute:
        return MaterialPageRoute(builder: (context)=>const QuotesHomeScreen(),
            // BlocProvider(
            // create: (context) => di.sl<RandomQuoteCubit>(),child: const QuotesHomeScreen())
        );
      case Routes.posts:
        return MaterialPageRoute(builder: (context)=>const PostsScreen(),
          // BlocProvider(
          // create: (context) => di.sl<RandomQuoteCubit>(),child: const QuotesHomeScreen())
        );

      // case Routes .quotesHomeScreen:
      //   return MaterialPageRoute(builder: (context)=>const QuotesHomeScreen());

      default:
        return undefinedRoute();
    }
  }
  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: ((context)=>const Scaffold(
      body: Center(
        child: Text(AppStrings.noRouteFound),
      ),
    )));
  }
}