import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_request_model.dart';
import 'package:jr_case_boilerplate/core/data/repositories/favorite_repository.dart';
import 'package:jr_case_boilerplate/cubit/add_favorite/add_favorite_state.dart';

class FavoriteCubit extends Cubit<AddFavoriteState> {
  final FavoriteRepository _repository;

  FavoriteCubit(this._repository) : super(FavoriteInitial());

  final Set<String> _favorites = {};

  bool isFavorite(String movieId) => _favorites.contains(movieId);

  Future<void> toggleFavorite(String movieId) async {
    emit(FavoriteLoading());
    try {
      final model = FavoriteRequestModel(favoriteId: movieId);
      final response = await _repository.addFavorite(model);

      if (_favorites.contains(movieId)) {
        _favorites.remove(movieId);
      } else {
        _favorites.add(movieId);
      }

      emit(FavoriteSuccess(response: response, favorites: _favorites));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }
}
