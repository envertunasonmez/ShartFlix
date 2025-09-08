class UploadPhotoResponseModel {
  final String photoUrl;
  final String message;

  UploadPhotoResponseModel({required this.photoUrl, required this.message});

  factory UploadPhotoResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadPhotoResponseModel(
      photoUrl: json['photoUrl'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
