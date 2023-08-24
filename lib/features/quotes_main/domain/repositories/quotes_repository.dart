///2
import 'package:dartz/dartz.dart';
import 'package:quotes/features/quotes_main/domain/entities/quotes_entity.dart';

import '../../../../core/error/failure.dart';

abstract class GetRandomQuotesRepository{
Future<Either<Failure , List<QuotesEntity>>> getRandomQuotes();
}