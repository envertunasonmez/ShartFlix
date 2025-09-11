class UploadPhotoResponseModel {
  final String photoUrl;
  final String message;

  UploadPhotoResponseModel({required this.photoUrl, required this.message});

  factory UploadPhotoResponseModel.fromJson(Map<dynamic, dynamic> json) {
    final map = Map<String, dynamic>.from(json);
    return UploadPhotoResponseModel(
      photoUrl: map['photoUrl'] ?? '',
      message: map['message'] ?? '',
    );
  }
}
