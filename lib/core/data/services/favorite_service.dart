import 'package:dio/dio.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_movie_list_response_model.dart';
import '../models/favorite_request_model.dart';
import '../models/favorite_response_model.dart';
import '../storage/token_storage.dart';

class FavoriteService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://caseapi.servicelabs.tech/"),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<FavoriteResponseModel> addFavorite(FavoriteRequestModel model) async {
    final token = await TokenStorage.getToken();

    final response = await _dio.post(
      "movie/favorite/${model.favoriteId}",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return FavoriteResponseModel.fromJson(response.data);
  }

  Future<FavoriteMovieListResponseModel> getFavorites() async {
    final token = await TokenStorage.getToken();

    final response = await _dio.get(
      "movie/favorites",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return FavoriteMovieListResponseModel.fromJson(response.data);
  }
}
