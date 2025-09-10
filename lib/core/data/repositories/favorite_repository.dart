import '../models/favorite_request_model.dart';
import '../models/favorite_response_model.dart';
import '../services/favorite_service.dart';

class FavoriteRepository {
  final FavoriteService _service;

  FavoriteRepository(this._service);

  Future<FavoriteResponseModel> addFavorite(FavoriteRequestModel model) async {
    return await _service.addFavorite(model);
  }
}
