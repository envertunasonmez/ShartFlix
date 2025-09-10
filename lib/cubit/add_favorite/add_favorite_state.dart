import 'package:jr_case_boilerplate/core/data/models/favorite_response_model.dart';

abstract class AddFavoriteState {}

class FavoriteInitial extends AddFavoriteState {}

class FavoriteLoading extends AddFavoriteState {}

class FavoriteSuccess extends AddFavoriteState {
  final FavoriteResponseModel response;
  final Set<String> favorites;

  FavoriteSuccess({required this.response, required this.favorites});
}

class FavoriteError extends AddFavoriteState {
  final String message;
  FavoriteError({required this.message});
}
