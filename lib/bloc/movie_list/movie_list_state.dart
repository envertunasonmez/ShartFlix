
import 'package:equatable/equatable.dart';
import 'package:jr_case_boilerplate/core/data/models/movie_response_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieListResponse response;

  const MovieLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object?> get props => [message];
}
