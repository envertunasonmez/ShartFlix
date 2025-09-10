
import 'package:jr_case_boilerplate/core/data/models/favorite_movie_list_response_model.dart';

abstract class FavoriteMovieListState {}

class FavoriteInitial extends FavoriteMovieListState {}

class FavoriteLoading extends FavoriteMovieListState {}

class FavoriteLoaded extends FavoriteMovieListState {
  final List<FavoriteMovie> movies;

  FavoriteLoaded(this.movies);
}

class FavoriteError extends FavoriteMovieListState {
  final String message;

  FavoriteError(this.message);
}
