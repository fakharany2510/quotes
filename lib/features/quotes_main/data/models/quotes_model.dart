///4
import 'package:quotes/features/quotes_main/domain/entities/quotes_entity.dart';

class QuotesModel extends QuotesEntity {
  const QuotesModel(
      {required super.quote, required super.author, required super.category});


  factory QuotesModel.fromJson(Map<String , dynamic> json)=> QuotesModel(
      quote: json["quote"],
      author: json["author"],
      category: json["category"]
  );

  Map<String, dynamic> toJson() => {
    "quote": quote,
    "author": author,
    "category": category,
  };
}
