import 'package:equatable/equatable.dart';
import '../../core/data/models/login_request_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final LoginRequestModel model;

  const LoginSubmitted(this.model);

  @override
  List<Object?> get props => [model];
}
