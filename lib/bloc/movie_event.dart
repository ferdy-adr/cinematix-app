part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {
  final int page;

  const FetchMovies(this.page);

  @override
  List<Object> get props => [page];
}
