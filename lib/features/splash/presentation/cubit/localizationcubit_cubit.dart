import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_strings.dart';

import '../../domain/use_cases/change_language_use_case.dart';
import '../../domain/use_cases/get_saved_language_use_case.dart';
import 'localizationcubit_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final ChangeLanguageUseCase changeLanguageUseCase;
  final GetSavedLanguageUseCase getSavedLanguageUseCase;
  LocalizationCubit(
      {required this.changeLanguageUseCase,
      required this.getSavedLanguageUseCase})
      : super(const ChangeLocalState(Locale(AppStrings.englishCode)));
  static LocalizationCubit get(context) => BlocProvider.of(context);


  ///get saved language
  String currentLanguageCode= AppStrings.englishCode;

 Future<void> getSavedLanguage()async{
  final response = await getSavedLanguageUseCase.call();
  response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value){
    currentLanguageCode=value!;
    emit(ChangeLocalState(Locale(currentLanguageCode)));
  });
}

  ///change locale
Future<void> _changeLanguage(String langCode)async{
  final response = await changeLanguageUseCase.call(langCode);
  response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value){
    currentLanguageCode=langCode;
    emit(ChangeLocalState(Locale(currentLanguageCode)));
  });
}

void changeLanguageToEnglish()=>_changeLanguage(AppStrings.englishCode);

void changeLanguageToArabic()=>_changeLanguage(AppStrings.arabicCode);
}
