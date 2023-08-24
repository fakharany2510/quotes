import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/Exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/splash/data/data_sources/language_local_data_source.dart';
import 'package:quotes/features/splash/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository{
  LanguageLocalDataSource languageLocalDataSource;
  LanguageRepositoryImpl({required this.languageLocalDataSource});
  @override
  Future<Either<Failure, bool>> changeLang({required String languageCode}) async{
    try{
      final changedLanguage = await languageLocalDataSource.changeLang(languageCode: languageCode);
      return Right(changedLanguage);
    }on CacheException{
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getSavedLang()async {
   try{
     final languageCode = await languageLocalDataSource.getSavedLang();
     return Right(languageCode);
   }on CacheException{
     return Left(CacheFailure());
   }
  }

}