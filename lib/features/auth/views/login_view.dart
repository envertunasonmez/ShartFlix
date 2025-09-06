import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:jr_case_boilerplate/features/auth/views/register_view.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 186,
                  width: 402,
                  child: Lottie.asset(
                    "assets/splash_animation.json",
                    fit: BoxFit.contain,
                  ),
                ),
                SvgPicture.asset(AppStrings.logoPath, height: 100),
                SizedBox(height: 4),
                Text(
                  'Giriş Yap',
                  style: AppTextStyles.heading32.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 29,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Kullanıcı bilgilerinle giriş yap',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.white90,
                  ),
                ),
                const SizedBox(height: 36),

                CustomTextField(
                  controller: _emailController,
                  labelText: "E-posta",
                  svgIconPath: AppStrings.emailIconPath,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: _passwordController,
                  labelText: "Şifre",
                  svgIconPath: AppStrings.passwordIconPath,
                  obscureText: true,
                ),

                // Şifremi Unuttum bağlantısı
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Şifremi unuttum fonksiyonu
                      debugPrint("Şifremi unuttum tıklandı");
                    },
                    child: Text(
                      "Şifremi Unuttum",
                      style: TextStyle(color: AppColors.white90, fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Giriş Yap butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      debugPrint("Email: $email, Password: $password");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Giriş Yap",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Sosyal medya giriş butonları
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      iconPath: AppStrings.googleIconPath,
                      onTap: () {
                        debugPrint("Google ile giriş");
                      },
                    ),
                    const SizedBox(width: 16), // 4px boşluk
                    _buildSocialButton(
                      iconPath: AppStrings.appleIconPath,
                      onTap: () {
                        debugPrint("Apple ile giriş");
                      },
                    ),
                    const SizedBox(width: 16), // 4px boşluk
                    _buildSocialButton(
                      iconPath: AppStrings.facebookIconPath,
                      onTap: () {
                        debugPrint("Facebook ile giriş");
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Kayıt ol bağlantısı
                // Kayıt ol bağlantısı
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterView(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hesabın yok mu? ",
                          style: AppTextStyles.bodyNormal.copyWith(
                            color: AppColors.white80,
                          ),
                        ),
                        const WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                          text: "Kayıt ol",
                          style: AppTextStyles.bodyNormal.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Sosyal medya butonu widget'ı
  Widget _buildSocialButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.white20, width: 1),
        ),
        child: Center(child: SvgPicture.asset(iconPath, width: 24, height: 24)),
      ),
    );
  }
}
