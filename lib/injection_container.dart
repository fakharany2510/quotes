import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/posts/data/data_sources/get_posts_remote_data_source.dart';
import 'package:quotes/features/posts/data/repositories/get_posts_repository_impl.dart';
import 'package:quotes/features/posts/domain/repositories/get_posts_repository.dart';
import 'package:quotes/features/posts/domain/use_cases/get_posts_use_case.dart';
import 'package:quotes/features/posts/presentation/cubits/get_posts_cubit.dart';
import 'package:quotes/features/quotes_main/data/data_sources/quotes_local_data_source.dart';
import 'package:quotes/features/quotes_main/data/data_sources/quotes_remote_data_source.dart';
import 'package:quotes/features/quotes_main/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/quotes_main/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/splash/data/data_sources/language_local_data_source.dart';
import 'package:quotes/features/splash/data/repositories/language_repository_impl.dart';
import 'package:quotes/features/splash/domain/repositories/language_repository.dart';
import 'package:quotes/features/splash/domain/use_cases/change_language_use_case.dart';
import 'package:quotes/features/splash/domain/use_cases/get_saved_language_use_case.dart';
import 'package:quotes/features/splash/presentation/cubit/localizationcubit_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/quotes_main/domain/repositories/quotes_repository.dart';
import 'features/quotes_main/domain/use_cases/quotes_use_case.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async{
  /// features
  /// blocs
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuotesUseCase: sl()));
  sl.registerFactory(() => GetPostsCubit(getPostsUseCase:sl() ));
  sl.registerFactory(() => LocalizationCubit(changeLanguageUseCase: sl(),getSavedLanguageUseCase: sl()));

  ///usecases
  sl.registerLazySingleton<GetRandomQuotesUseCase>(() => GetRandomQuotesUseCase(quotesRepository:sl()));
  sl.registerLazySingleton<ChangeLanguageUseCase>(() => ChangeLanguageUseCase(languageRepository: sl()));
  sl.registerLazySingleton<GetSavedLanguageUseCase>(() => GetSavedLanguageUseCase(languageRepository: sl()));
  sl.registerLazySingleton<GetPostsUseCase>(() => GetPostsUseCase(getPostsRepository:sl()));

  ///repositories
  sl.registerLazySingleton<GetRandomQuotesRepository>(() => GetRandomQuoteRepositoryImpl(
      netWorkInfo: sl(),
      quotesRemotesDataSource: sl(),
      quotesLocalDataSource: sl()));
  sl.registerLazySingleton<LanguageRepository>(() => LanguageRepositoryImpl(
     languageLocalDataSource: sl())
  );
  sl.registerLazySingleton<GetPostsRepository>(() => GetPostsRepositoryImpl(
    getPostsRemoteDataSource:sl(),
    networkInfo:sl(),
  ));


  ///remote dataSource
  sl.registerLazySingleton<QuotesRemotesDataSource>(() => QuotesRemotesDataSourceImpl(apiConsumer:sl()));
  sl.registerLazySingleton<GetPostsRemoteDataSource>(() => GetPostsRemoteDataSourceImpl(apiConsumer:sl()));

  ///local dataSource
  sl.registerLazySingleton<QuotesLocalDataSource>(() => QuotesLocalDataSourceImpl(sharedPreferences:sl()));
  sl.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl(sharedPreferences:sl()));

  ///core
  sl.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));


  ///external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    error: true,
  ));


}
