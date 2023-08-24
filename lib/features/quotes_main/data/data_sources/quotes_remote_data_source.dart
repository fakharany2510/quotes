import 'dart:convert';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/error/Exceptions.dart';
import 'package:quotes/core/network/api_constance.dart';
import 'package:quotes/features/quotes_main/data/models/quotes_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_consumer.dart';

abstract class QuotesRemotesDataSource{
  Future<List<QuotesModel>> getRandomQuote();
}


class QuotesRemotesDataSourceImpl implements QuotesRemotesDataSource{
  ApiConsumer apiConsumer;
  QuotesRemotesDataSourceImpl({required this.apiConsumer});

  @override
  List<QuotesModel>? quotesList;
  Future<List<QuotesModel>> getRandomQuote()async {
    quotesList=[];
    dynamic response = await apiConsumer.get(EndPoints.randomQuotes);

    // dynamic response = await apiConsumer.get(EndPoints.randomQuotes,queryParameters: {
    //   'category':'happiness'
    // });
    quotesList!.add(QuotesModel.fromJson(response[0]));
     return quotesList!;

  }

}