///3
import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/quotes_main/domain/entities/quotes_entity.dart';
import 'package:quotes/features/quotes_main/domain/repositories/quotes_repository.dart';

 class GetRandomQuotesUseCase{
  GetRandomQuotesRepository quotesRepository;
  GetRandomQuotesUseCase({required this.quotesRepository});


  Future<Either<Failure , List<QuotesEntity>>> call(){
    return  quotesRepository.getRandomQuotes();
  }
}