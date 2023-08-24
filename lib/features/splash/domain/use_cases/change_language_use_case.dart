import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/language_repository.dart';

class ChangeLanguageUseCase{
  LanguageRepository languageRepository;
  ChangeLanguageUseCase({required this.languageRepository});


  Future<Either<Failure, bool>> call(String languageCode){
    return  languageRepository.changeLang(languageCode: languageCode);
  }
}