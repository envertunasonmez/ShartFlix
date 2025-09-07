import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_elevated_button.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isTermsAccepted;
  final Function(bool?) onTermsChanged;
  final VoidCallback onRegisterPressed;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isTermsAccepted,
    required this.onTermsChanged,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextField(
          controller: nameController,
          labelText: "Ad Soyad",
          svgIconPath: AppStrings.userIconPath,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: emailController,
          labelText: "Email",
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
        const SizedBox(height: 20),
        CustomTextField(
          controller: confirmPasswordController,
          labelText: "Şifre (Tekrar)",
          svgIconPath: AppStrings.passwordIconPath,
          obscureText: true,
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
                      text: ". Bu sözleşmeyi okuyarak devam ediniz lütfen.",
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
        CustomElevatedButton(text: "Kayıt Ol", onPressed: onRegisterPressed),
      ],
    );
  }
}
