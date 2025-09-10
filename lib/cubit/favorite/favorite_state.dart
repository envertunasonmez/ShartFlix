import 'package:jr_case_boilerplate/core/data/models/favorite_response_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final FavoriteResponseModel response;
  final Set<String> favorites;

  FavoriteSuccess({required this.response, required this.favorites});
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError({required this.message});
}
