import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_elevated_button.dart';

typedef UploadPhotoCallback = void Function(String photoPath);

class ActionButtonsSection extends StatelessWidget {
  final bool isPhotoSelected;
  final UploadPhotoCallback? onUpload;
  final String? photoPath;
  const ActionButtonsSection({
    super.key,
    required this.isPhotoSelected,
    this.onUpload,
    this.photoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          text: "Devam Et",
          onPressed: isPhotoSelected && onUpload != null && photoPath != null
              ? () {
                  onUpload!(photoPath!);
                }
              : null,
          backgroundColor: isPhotoSelected
              ? AppColors.primary
              : AppColors.white90,
          textColor: AppColors.whiteColor,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            context.go(AppRoutes.mainWrapper);
          },
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
