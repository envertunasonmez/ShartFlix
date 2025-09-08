import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/data/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc({required ProfileRepository repository}) 
    : _repository = repository, 
      super(ProfileInitial()) {
    
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await _repository.getProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileUpdating());
      try {
        final profile = await _repository.updateProfile(event.data);
        emit(ProfileUpdated(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}