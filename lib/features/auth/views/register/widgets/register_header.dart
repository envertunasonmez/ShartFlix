import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';

class RegisterHeader extends StatelessWidget {
  final double height;

  const RegisterHeader({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.1),
        SvgPicture.asset(AppStrings.logoPath, height: height * 0.12),
        const SizedBox(height: 12),
        Text(
          "Hesap Oluştur",
          style: AppTextStyles.heading24.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Kullanıcı bilgilerini girerek kaydol",
          style: AppTextStyles.bodyNormal.copyWith(
            color: AppColors.white90,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
