import 'package:cinematix/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
      if (event is FetchMovies) {
        List<Movie> movies = await MovieServices.getMovies(event.page);

        emit(MovieLoaded(movies));
      }
    });
  }
}
