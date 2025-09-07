import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_elevated_button.dart';

class ActionButtonsSection extends StatelessWidget {
  final bool isPhotoSelected;
  const ActionButtonsSection({super.key, required this.isPhotoSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          text: "Devam Et",
          onPressed: isPhotoSelected ? () {} : null,
          backgroundColor:
              isPhotoSelected ? AppColors.primary : AppColors.white90,
          textColor: AppColors.whiteColor,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: Text(
            "Atla",
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
