import 'package:dio/dio.dart';
import 'package:jr_case_boilerplate/core/network/dio_client.dart';
import 'package:jr_case_boilerplate/core/data/models/movie_response_model.dart';
import 'package:jr_case_boilerplate/core/data/storage/token_storage.dart';

class MovieService {
  final Dio _dio;
  MovieService({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<MovieListResponse> getMovies({int page = 1}) async {
    final token = await TokenStorage.getToken();

    final response = await _dio.get(
      "movie/list",
      queryParameters: {"page": page},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return MovieListResponse.fromJson(response.data);
  }
}
