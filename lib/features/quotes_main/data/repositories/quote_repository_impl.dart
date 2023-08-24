import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/Exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/quotes_main/data/data_sources/quotes_local_data_source.dart';
import 'package:quotes/features/quotes_main/data/data_sources/quotes_remote_data_source.dart';
import 'package:quotes/features/quotes_main/data/models/quotes_model.dart';
import 'package:quotes/features/quotes_main/domain/repositories/quotes_repository.dart';

class GetRandomQuoteRepositoryImpl implements GetRandomQuotesRepository {
  final NetWorkInfo netWorkInfo;
  final QuotesRemotesDataSource quotesRemotesDataSource;
  final QuotesLocalDataSource quotesLocalDataSource;

  const GetRandomQuoteRepositoryImpl(
      {required this.netWorkInfo,
      required this.quotesRemotesDataSource,
      required this.quotesLocalDataSource});

  @override
  Future<Either<Failure, List<QuotesModel>>> getRandomQuotes()async {
    if(await netWorkInfo.isConnected){
      try {
        final result = await quotesRemotesDataSource.getRandomQuote();
        quotesLocalDataSource.cacheQuote(result[0]);
        return Right(result);
      } on ServerException  {
        return Left(ServerFailure());
      }

    }else{
      try {
        final result = await quotesLocalDataSource.getLastCachedQuote();
        List<QuotesModel> list=[];
        list.add(result);
        return Right(list);
      } on CacheException  {
        return Left(CacheFailure());
      }
    }
  }


  /*
  * if(isConnected){
  * get data from api
  * }else{
  *
  *get data from cache
  * }
  *
  * */
}
