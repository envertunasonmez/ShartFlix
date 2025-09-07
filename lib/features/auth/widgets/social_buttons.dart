import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class SocialButtons extends StatelessWidget {
  final double width;

  const SocialButtons({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          iconPath: AppStrings.googleIconPath,
          onTap: () => debugPrint("Google ile giriş"),
        ),
        SizedBox(width: width * 0.04),
        _buildSocialButton(
          iconPath: AppStrings.appleIconPath,
          onTap: () => debugPrint("Apple ile giriş"),
        ),
        SizedBox(width: width * 0.04),
        _buildSocialButton(
          iconPath: AppStrings.facebookIconPath,
          onTap: () => debugPrint("Facebook ile giriş"),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.14,
        height: width * 0.14,
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(width * 0.04),
          border: Border.all(color: AppColors.white20, width: 1),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: width * 0.06,
            height: width * 0.06,
          ),
        ),
      ),
    );
  }
}
