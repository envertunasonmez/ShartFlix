class FavoriteResponseModel {
  final bool success;
  final String message;

  FavoriteResponseModel({
    required this.success,
    required this.message,
  });

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    return FavoriteResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
