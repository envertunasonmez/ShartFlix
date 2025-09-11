import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jr_case_boilerplate/core/data/repositories/upload_photo_repository.dart';
import 'upload_photo_event.dart';
import 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final UploadPhotoRepository _repository;
  final ImagePicker _picker = ImagePicker();

  UploadPhotoBloc({required UploadPhotoRepository repository})
    : _repository = repository,
      super(UploadPhotoInitial()) {
    on<UploadPhotoRequested>((event, emit) async {
      emit(UploadPhotoLoading());
      try {
        final response = await _repository.uploadPhoto(event.photoUrl);
        emit(UploadPhotoSuccess(response));
      } catch (e) {
        emit(UploadPhotoError(e.toString()));
      }
    });
    on<PickPhotoRequested>((event, emit) async {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(PhotoPickedSuccess(pickedFile.path));
        } else {
          emit(PhotoPickedError('Fotoğraf seçilmedi.'));
        }
      } catch (e) {
        emit(PhotoPickedError('Fotoğraf seçilemedi: ' + e.toString()));
      }
    });
    on<ResetUploadPhoto>((event, emit) async {
      emit(UploadPhotoInitial());
    });
    on<RemovePhotoRequested>((event, emit) async {
      emit(UploadPhotoInitial());
    });
  }
}
