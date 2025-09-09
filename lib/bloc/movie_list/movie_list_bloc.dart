

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/movie_list/movie_list_event.dart';
import 'package:jr_case_boilerplate/bloc/movie_list/movie_list_state.dart';
import 'package:jr_case_boilerplate/core/data/repositories/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc(this.repository) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final response = await repository.getMovies(page: event.page);
        emit(MovieLoaded(response));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}
