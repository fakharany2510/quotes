import 'dart:convert';

import 'package:quotes/core/error/Exceptions.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/extensions.dart';
import 'package:quotes/features/quotes_main/data/models/quotes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class QuotesLocalDataSource{
  Future<QuotesModel> getLastCachedQuote();
  Future<void> cacheQuote(QuotesModel quotesModel);
}

class QuotesLocalDataSourceImpl implements QuotesLocalDataSource{
  final SharedPreferences sharedPreferences;
  QuotesLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheQuote(QuotesModel quotesModel) {
    return sharedPreferences.setString(AppStrings.cachedRandomQuote, json.encode(quotesModel));
  }

  @override
  Future<QuotesModel> getLastCachedQuote() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedRandomQuote);
    if(jsonString != null){
      final  Future<QuotesModel> cachedRandomQuote = Future.value(QuotesModel.fromJson(json.decode(jsonString)));
      return cachedRandomQuote;
    }else{
      throw CacheException();
    }
  }



}