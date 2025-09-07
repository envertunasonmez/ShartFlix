import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_elevated_button.dart';

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

  @override
  Widget build(BuildContext context) {
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
        CustomElevatedButton(
          text: "Giriş Yap",
          onPressed: () {
            final email = emailController.text;
            final password = passwordController.text;
            debugPrint("Email: $email, Password: $password");
          },
        ),
      ],
    );
  }
}
