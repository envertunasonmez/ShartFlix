
import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovies extends MovieEvent {
  final int page;

  const FetchMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}
