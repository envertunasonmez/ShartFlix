import 'package:jr_case_boilerplate/core/data/models/upload_photo_response_model.dart';

abstract class UploadPhotoState {}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoLoading extends UploadPhotoState {}

class UploadPhotoSuccess extends UploadPhotoState {
  final UploadPhotoResponseModel response;
  UploadPhotoSuccess(this.response);
}

class UploadPhotoError extends UploadPhotoState {
  final String message;
  UploadPhotoError(this.message);
}

class PhotoPickedSuccess extends UploadPhotoState {
  final String photoPath;
  PhotoPickedSuccess(this.photoPath);
}

class PhotoPickedError extends UploadPhotoState {
  final String message;
  PhotoPickedError(this.message);
}
