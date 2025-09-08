import 'package:equatable/equatable.dart';
import 'package:jr_case_boilerplate/core/data/models/register_request_model.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final RegisterRequestModel model;

  RegisterSubmitted(this.model);

  @override
  List<Object?> get props => [model];
}
