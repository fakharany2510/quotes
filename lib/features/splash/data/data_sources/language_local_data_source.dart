import 'package:quotes/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Future<bool> changeLang({required String languageCode});
  Future<String?> getSavedLang();
}


class LanguageLocalDataSourceImpl implements
    LanguageLocalDataSource{
  final SharedPreferences sharedPreferences;
  LanguageLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<bool> changeLang({required String languageCode}) async=>
      await sharedPreferences.setString(AppStrings.locale, languageCode);
  @override
  Future<String?> getSavedLang() async =>
       sharedPreferences.containsKey(AppStrings.locale)
      ?sharedPreferences.getString(AppStrings.locale)
          :AppStrings.englishCode;

}