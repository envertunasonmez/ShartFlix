abstract class UploadPhotoEvent {}

class RemovePhotoRequested extends UploadPhotoEvent {}

class ResetUploadPhoto extends UploadPhotoEvent {}

class UploadPhotoRequested extends UploadPhotoEvent {
  final String photoUrl;
  UploadPhotoRequested(this.photoUrl);
}

class PickPhotoRequested extends UploadPhotoEvent {}
