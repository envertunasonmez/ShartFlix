import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
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

  const RegisterForm({
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: nameController,
                labelText: "Ad Soyad",
                svgIconPath: AppStrings.userIconPath,
                hasError: isUpdated && validationState.errors['name'] != null,
                errorText: isUpdated ? validationState.errors['name'] : null,
                validator: (value) {
                  final error = context
                      .read<FormValidationCubit>()
                      .validateName(value);
                  context.read<FormValidationCubit>().updateFieldValidation(
                    'name',
                    error,
                  );
                  return null;
                },
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                controller: emailController,
                labelText: "Email",
                svgIconPath: AppStrings.emailIconPath,
                keyboardType: TextInputType.emailAddress,
                hasError: isUpdated && validationState.errors['email'] != null,
                errorText: isUpdated ? validationState.errors['email'] : null,
                validator: (value) {
                  final error = context
                      .read<FormValidationCubit>()
                      .validateEmail(value);
                  context.read<FormValidationCubit>().updateFieldValidation(
                    'email',
                    error,
                  );
                  return null;
                },
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                controller: passwordController,
                labelText: "Şifre",
                svgIconPath: AppStrings.passwordIconPath,
                obscureText: true,
                hasError:
                    isUpdated && validationState.errors['password'] != null,
                errorText: isUpdated
                    ? validationState.errors['password']
                    : null,
                validator: (value) {
                  final error = context
                      .read<FormValidationCubit>()
                      .validatePassword(value);
                  context.read<FormValidationCubit>().updateFieldValidation(
                    'password',
                    error,
                  );

                  if (confirmPasswordController.text.isNotEmpty) {
                    final confirmError = context
                        .read<FormValidationCubit>()
                        .validateConfirmPassword(
                          confirmPasswordController.text,
                          value ?? '',
                        );
                    context.read<FormValidationCubit>().updateFieldValidation(
                      'confirmPassword',
                      confirmError,
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                controller: confirmPasswordController,
                labelText: "Şifre (Tekrar)",
                svgIconPath: AppStrings.passwordIconPath,
                obscureText: true,
                hasError:
                    isUpdated &&
                    validationState.errors['confirmPassword'] != null,
                errorText: isUpdated
                    ? validationState.errors['confirmPassword']
                    : null,
                validator: (value) {
                  final error = context
                      .read<FormValidationCubit>()
                      .validateConfirmPassword(value, passwordController.text);
                  context.read<FormValidationCubit>().updateFieldValidation(
                    'confirmPassword',
                    error,
                  );
                  return null;
                },
              ),
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: isTermsAccepted,
                      onChanged: onTermsChanged,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(color: AppColors.white20, width: 1.5),
                      checkColor: AppColors.whiteColor,
                      activeColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Kullanıcı sözleşmesini ",
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white60,
                            ),
                          ),
                          TextSpan(
                            text: "Okudum ve Kabul ediyorum",
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.whiteColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                debugPrint("Sözleşme tıklandı!");
                              },
                          ),
                          TextSpan(
                            text:
                                ". Bu sözleşmeyi okuyarak devam ediniz lütfen.",
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              CustomElevatedButton(
                text: "Kayıt Ol",
                onPressed: () {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  final confirmPassword = confirmPasswordController.text.trim();

                  context.read<FormValidationCubit>().validateRegisterForm(
                    name,
                    email,
                    password,
                    confirmPassword,
                  );

                  if (!isTermsAccepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Koşulları kabul etmelisiniz!",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        backgroundColor: AppColors.error,
                      ),
                    );
                    return;
                  }

                  final currentState = context
                      .read<FormValidationCubit>()
                      .state;
                  if (currentState is FormValidationUpdated &&
                      currentState.isValid) {
                    onRegisterPressed();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
