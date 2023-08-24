///1
import 'package:equatable/equatable.dart';

class QuotesEntity extends Equatable{
  final String quote;
  final String author;
  final String category;

  const QuotesEntity({
    required this.quote,
    required this.author,
    required this.category
});
  @override
  List<Object?> get props => [
    quote,
    author,
    category
  ];

}
