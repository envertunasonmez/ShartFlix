import 'package:equatable/equatable.dart';
import 'package:jr_case_boilerplate/core/data/models/register_response_model.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponseModel response;

  RegisterSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}
