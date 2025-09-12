import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_request_model.dart';
import 'package:jr_case_boilerplate/core/data/repositories/favorite_repository.dart';
import 'package:jr_case_boilerplate/cubit/favorite_movies/favorite_movie_list_state.dart';


class FavoriteMovieListCubit extends Cubit<FavoriteMovieListState> {
  final FavoriteRepository _repository;

  FavoriteMovieListCubit(this._repository) : super(FavoriteInitial());

  Future<void> fetchFavorites() async {
    try {
      emit(FavoriteLoading());
      final response = await _repository.getFavorites();
      emit(FavoriteLoaded(response.movies));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> addFavorite(String favoriteId) async {
    try {
      emit(FavoriteLoading());
      await _repository.addFavorite(FavoriteRequestModel(favoriteId: favoriteId));
      await fetchFavorites();
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
