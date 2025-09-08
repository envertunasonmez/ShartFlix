import '../services/upload_photo_service.dart';
import '../models/upload_photo_response_model.dart';

class UploadPhotoRepository {
  final UploadPhotoService _service;

  UploadPhotoRepository(this._service);

  Future<UploadPhotoResponseModel> uploadPhoto(String photoUrl) async {
    try {
      return await _service.uploadPhoto(photoUrl);
    } catch (e) {
      throw Exception('Failed to upload photo: $e');
    }
  }
}
