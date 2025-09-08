class ResetUploadPhoto extends UploadPhotoEvent {}
abstract class UploadPhotoEvent {}

class UploadPhotoRequested extends UploadPhotoEvent {
  final String photoUrl;
  UploadPhotoRequested(this.photoUrl);
}

class PickPhotoRequested extends UploadPhotoEvent {}
