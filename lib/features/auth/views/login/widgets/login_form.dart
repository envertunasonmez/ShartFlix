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
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double width;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.width,
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Giriş başarılı!",
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.success,
            ),
          );

          final userId = state.response.user.id;
          final firstLogin = await _isFirstLogin(userId);

          if (firstLogin) {
            context.go(AppRoutes.uploadPhoto);
          } else {
            context.go(AppRoutes.mainWrapper);
          }
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              controller: emailController,
              labelText: "E-posta",
              svgIconPath: AppStrings.emailIconPath,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              labelText: "Şifre",
              svgIconPath: AppStrings.passwordIconPath,
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  debugPrint("Şifremi unuttum tıklandı");
                },
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
            state is LoginLoading
                ? const CircularProgressIndicator()
                : CustomElevatedButton(
                    text: "Giriş Yap",
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      final model = LoginRequestModel(
                        email: email,
                        password: password,
                      );

                      context.read<LoginBloc>().add(LoginSubmitted(model));
                    },
                  ),
          ],
        );
      },
    );
  }
}
