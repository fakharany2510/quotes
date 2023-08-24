import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';

abstract class LanguageRepository{
  Future<Either<Failure , bool>> changeLang({required String languageCode});
  Future<Either<Failure , String?>> getSavedLang();
}