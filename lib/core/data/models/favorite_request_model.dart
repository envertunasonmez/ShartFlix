class FavoriteRequestModel {
  final String favoriteId;

  FavoriteRequestModel({required this.favoriteId});

  Map<String, dynamic> toJson() => {
        "favoriteId": favoriteId,
      };
}
