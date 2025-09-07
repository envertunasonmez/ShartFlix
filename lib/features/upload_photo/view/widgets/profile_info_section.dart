import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SvgPicture.asset(
          AppStrings.profilePicIcon,
          width: 76,
          height: 76,
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          "Fotoğraf Yükle",
          style: AppTextStyles.heading24.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Profil fotoğrafın için görsel yükleyebilirsin",
          style: AppTextStyles.bodyNormal.copyWith(
            color: AppColors.white90,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
