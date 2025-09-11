import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.go(AppRoutes.mainWrapper);
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white5,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.white20),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppStrings.backArrowIcon,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Profil Detayı",
              style: AppTextStyles.bodyXLarge.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }
}
