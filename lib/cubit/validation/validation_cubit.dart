import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(FormValidationInitial());

  Map<String, String?> _errors = {};

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta adresi gereklidir';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }

    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre gereklidir';
    }

    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }

    return null;
  }

  // Name validation
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ad soyad gereklidir';
    }

    if (value.trim().length < 2) {
      return 'Ad soyad en az 2 karakter olmalıdır';
    }

    return null;
  }

  // Confirm password validation
  String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Şifre tekrarı gereklidir';
    }

    if (value != originalPassword) {
      return 'Şifreler eşleşmiyor';
    }

    return null;
  }

  // Update field validation
  void updateFieldValidation(String fieldName, String? error) {
    _errors[fieldName] = error;

    final isValid = _errors.values.every((error) => error == null);

    emit(FormValidationUpdated(errors: Map.from(_errors), isValid: isValid));
  }

  // Validate login form
  void validateLoginForm(String email, String password) {
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    _errors['email'] = emailError;
    _errors['password'] = passwordError;

    final isValid = emailError == null && passwordError == null;

    emit(FormValidationUpdated(errors: Map.from(_errors), isValid: isValid));
  }

  // Validate register form
  void validateRegisterForm(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    final nameError = validateName(name);
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);
    final confirmPasswordError = validateConfirmPassword(
      confirmPassword,
      password,
    );

    _errors['name'] = nameError;
    _errors['email'] = emailError;
    _errors['password'] = passwordError;
    _errors['confirmPassword'] = confirmPasswordError;

    final isValid =
        nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;

    emit(FormValidationUpdated(errors: Map.from(_errors), isValid: isValid));
  }

  // Clear all errors
  void clearErrors() {
    _errors.clear();
    emit(FormValidationInitial());
  }

  // Get error for specific field
  String? getError(String fieldName) {
    final state = this.state;
    if (state is FormValidationUpdated) {
      return state.errors[fieldName];
    }
    return null;
  }

  // Check if field has error
  bool hasError(String fieldName) {
    return getError(fieldName) != null;
  }
}
