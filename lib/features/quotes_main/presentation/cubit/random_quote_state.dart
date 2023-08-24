part of 'random_quote_cubit.dart';

abstract class RandomQuoteState extends Equatable{
const RandomQuoteState();
@override
List<Object?> get props => [];
}

class RandomQuoteInitial extends RandomQuoteState {}

class RandomQuoteLoading extends RandomQuoteState {}

class RandomQuoteLoaded extends RandomQuoteState {
  final List<QuotesEntity> quotes;
  const RandomQuoteLoaded({required this.quotes});
  @override
  List<Object?> get props => [quotes];
}

class RandomQuoteError extends RandomQuoteState {
  final String msg;
  const RandomQuoteError({required this.msg});
  @override
  List<Object?> get props => [msg];
}
