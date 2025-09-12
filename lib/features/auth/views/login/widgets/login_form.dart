import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/login/login_bloc.dart';
import 'package:jr_case_boilerplate/bloc/login/login_event.dart';
import 'package:jr_case_boilerplate/bloc/login/login_state.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_elevated_button.dart';
import 'package:jr_case_boilerplate/core/data/models/login_request_model.dart';
import 'package:go_router/go_router.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_cubit.dart';
import 'package:jr_case_boilerplate/cubit/validation/validation_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double width;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.width,
    required this.formKey,
  });

  Future<bool> _isFirstLogin(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "first_login_$userId";
    if (!prefs.containsKey(key)) {
      await prefs.setBool(key, false);
      return true;
    }
    return false;
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.whiteColor),
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginFailure) {
              context.read<FormValidationCubit>().updateFieldValidation(
                'password',
                'Yanlış şifre girdiniz, lütfen tekrar deneyin',
              );

              _showSnackBar(context, state.error, AppColors.error);
            }

            if (state is LoginSuccess) {
              context.read<FormValidationCubit>().clearErrors();
              _showSnackBar(context, "Giriş başarılı!", AppColors.success);

              final userId = state.response.user.id;
              final firstLogin = await _isFirstLogin(userId);

              context.go(
                firstLogin ? AppRoutes.uploadPhoto : AppRoutes.mainWrapper,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<FormValidationCubit, FormValidationState>(
        builder: (context, validationState) {
          final errors = validationState is FormValidationUpdated
              ? validationState.errors
              : {};

          return Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: emailController,
                  labelText: "E-posta",
                  svgIconPath: AppStrings.emailIconPath,
                  keyboardType: TextInputType.emailAddress,
                  hasError: errors['email'] != null,
                  errorText: errors['email'],
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
                  hasError: errors['password'] != null,
                  errorText: errors['password'],
                  validator: (value) {
                    final error = context
                        .read<FormValidationCubit>()
                        .validatePassword(value);
                    context.read<FormValidationCubit>().updateFieldValidation(
                      'password',
                      error,
                    );
                    return null;
                  },
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => debugPrint("Şifremi unuttum tıklandı"),
                    child: Text(
                      "Şifremi Unuttum",
                      style: AppTextStyles.bodyNormal.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, loginState) {
                    if (loginState is LoginLoading) {
                      return const CircularProgressIndicator(
                        color: AppColors.primary,
                      );
                    }

                    return CustomElevatedButton(
                      text: "Giriş Yap",
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        context.read<FormValidationCubit>().validateLoginForm(
                          email,
                          password,
                        );

                        final currentState = context
                            .read<FormValidationCubit>()
                            .state;
                        if (currentState is FormValidationUpdated &&
                            currentState.isValid) {
                          final model = LoginRequestModel(
                            email: email,
                            password: password,
                          );
                          context.read<LoginBloc>().add(LoginSubmitted(model));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
