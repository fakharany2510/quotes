import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_strings.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/quotes_entity.dart';
import '../../domain/use_cases/quotes_use_case.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuotesUseCase getRandomQuotesUseCase;

  RandomQuoteCubit({required this.getRandomQuotesUseCase})
      : super(RandomQuoteInitial());

  static RandomQuoteCubit get(context) => BlocProvider.of(context);


  Future<void> getRandomQuote() async {
    emit(RandomQuoteLoading());
    Either<Failure, List<QuotesEntity>> response = await getRandomQuotesUseCase();
    emit(
      response.fold((failure) =>
          RandomQuoteError(msg: _mapFailureToMsg(failure)), (QuotesEntity) =>
          RandomQuoteLoaded(quotes: QuotesEntity)),
    );
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;

      default:
        return AppStrings.unExpectedFailure;
    }
  }
}
