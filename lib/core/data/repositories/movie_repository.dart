import 'package:jr_case_boilerplate/core/data/models/movie_response_model.dart';

import '../services/movie_service.dart';

class MovieRepository {
  final MovieService _service;

  MovieRepository(this._service);

  Future<MovieListResponse> getMovies({int page = 1}) async {
    return await _service.getMovies(page: page);
  }
}
