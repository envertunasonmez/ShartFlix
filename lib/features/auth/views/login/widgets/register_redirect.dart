import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/features/auth/views/register_view.dart';

class RegisterRedirect extends StatelessWidget {
  final double width;

  const RegisterRedirect({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterView(),
          ),
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Hesabın yok mu? ",
              style: AppTextStyles.bodyNormal.copyWith(
                color: AppColors.white70,
                fontSize: width * 0.035,
              ),
            ),
            const WidgetSpan(child: SizedBox(width: 8)),
            TextSpan(
              text: "Kayıt ol",
              style: AppTextStyles.bodyNormal.copyWith(
                color: AppColors.whiteColor,
                fontSize: width * 0.037,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
