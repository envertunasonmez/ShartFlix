abstract class FormValidationState {}

class FormValidationInitial extends FormValidationState {}

class FormValidationUpdated extends FormValidationState {
  final Map<String, String?> errors;
  final bool isValid;

  FormValidationUpdated({required this.errors, required this.isValid});
}
