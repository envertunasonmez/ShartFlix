import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:lottie/lottie.dart';

class LoginHeader extends StatelessWidget {
  final double height;
  final double width;

  const LoginHeader({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.2,
          width: width * 0.9,
          child: Lottie.asset(
            "assets/splash_animation.json",
            fit: BoxFit.contain,
          ),
        ),
        SvgPicture.asset(
          AppStrings.logoPath,
          height: height * 0.12,
        ),
        const SizedBox(height: 12),
        Text(
          'Giriş Yap',
          style: AppTextStyles.heading32.copyWith(
            color: AppColors.whiteColor,
            fontSize: width * 0.07,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Kullanıcı bilgilerinle giriş yap',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white90,
            fontSize: width * 0.04,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
