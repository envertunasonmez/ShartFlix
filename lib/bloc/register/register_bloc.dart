import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/data/repositories/auth_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final response = await authRepository.register(event.model);
        emit(RegisterSuccess(response));
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
