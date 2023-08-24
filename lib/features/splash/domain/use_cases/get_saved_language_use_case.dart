import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/language_repository.dart';

/// rerad language from SharedPreferences when application oppend
/// if he didnt found any language saved in SharedPreferences he will take the language from
/// change language UseCase and will take english language as default

class GetSavedLanguageUseCase{
  LanguageRepository languageRepository;
  GetSavedLanguageUseCase({required this.languageRepository});


  Future<Either<Failure, String?>> call(){
    return  languageRepository.getSavedLang();
  }
}