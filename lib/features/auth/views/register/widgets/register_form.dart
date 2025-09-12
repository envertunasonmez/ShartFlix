import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_elevated_button.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_cubit.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_state.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isTermsAccepted;
  final Function(bool?) onTermsChanged;
  final VoidCallback onRegisterPressed;
  final GlobalKey<FormState> formKey;

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isTermsAccepted,
    required this.onTermsChanged,
    required this.onRegisterPressed,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormValidationCubit, FormValidationState>(
      builder: (context, validationState) {
        final isUpdated = validationState is FormValidationUpdated;

        return Form(
          key: formKey,
          child: Column(
            children: [
              // Name Surname
              CustomTextFormField(
                controller: nameController,
                labelText: "Ad Soyad",
                svgIconPath: AppStrings.userIconPath,
                focusNode: nameFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(emailFocus);
                },
                hasError: isUpdated && validationState.errors['name'] != null,
                errorText: isUpdated ? validationState.errors['name'] : null,
                validator: (value) {
                  final error = context.read<FormValidationCubit>().validateName(value);
                  context.read<FormValidationCubit>().updateFieldValidation('name', error);
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //  Email
              CustomTextFormField(
                controller: emailController,
                labelText: "Email",
                svgIconPath: AppStrings.emailIconPath,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },
                hasError: isUpdated && validationState.errors['email'] != null,
                errorText: isUpdated ? validationState.errors['email'] : null,
                validator: (value) {
                  final error = context.read<FormValidationCubit>().validateEmail(value);
                  context.read<FormValidationCubit>().updateFieldValidation('email', error);
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password
              CustomTextFormField(
                controller: passwordController,
                labelText: "Şifre",
                svgIconPath: AppStrings.passwordIconPath,
                obscureText: true,
                focusNode: passwordFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(confirmPasswordFocus);
                },
                hasError: isUpdated && validationState.errors['password'] != null,
                errorText: isUpdated ? validationState.errors['password'] : null,
                validator: (value) {
                  final error = context.read<FormValidationCubit>().validatePassword(value);
                  context.read<FormValidationCubit>().updateFieldValidation('password', error);
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //  Password Again 
              CustomTextFormField(
                controller: confirmPasswordController,
                labelText: "Şifre (Tekrar)",
                svgIconPath: AppStrings.passwordIconPath,
                obscureText: true,
                focusNode: confirmPasswordFocus,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  onRegisterPressed(); 
                },
                hasError: isUpdated && validationState.errors['confirmPassword'] != null,
                errorText: isUpdated ? validationState.errors['confirmPassword'] : null,
                validator: (value) {
                  final error = context
                      .read<FormValidationCubit>()
                      .validateConfirmPassword(value, passwordController.text);
                  context.read<FormValidationCubit>().updateFieldValidation('confirmPassword', error);
                  return null;
                },
              ),
              const SizedBox(height: 20),

              CustomElevatedButton(
                text: "Kayıt Ol",
                onPressed: onRegisterPressed,
              ),
            ],
          ),
        );
      },
    );
  }
}
