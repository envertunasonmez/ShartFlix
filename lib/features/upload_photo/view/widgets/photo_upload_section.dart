import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/dash_border_painter.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';

class PhotoUploadSection extends StatelessWidget {
  final ImageProvider? selectedImage;
  final VoidCallback onPickImage;
  final VoidCallback? onRemoveImage;

  const PhotoUploadSection({
    super.key,
    required this.selectedImage,
    required this.onPickImage,
    this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 176,
          height: 176,
          child: CustomPaint(
            painter: DashedBorderPainter(
              color: AppColors.white20,
              strokeWidth: 1.0,
              dashLength: 8.0,
              gapLength: 4.0,
              borderRadius: 32.0,
            ),
            child: Container(
              width: 176,
              height: 176,
              decoration: BoxDecoration(
                color: AppColors.white5,
                borderRadius: BorderRadius.circular(32),
                image: selectedImage != null
                    ? DecorationImage(image: selectedImage!, fit: BoxFit.cover)
                    : null,
              ),
              child: selectedImage == null
                  ? GestureDetector(
                      onTap: onPickImage,
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
        if (selectedImage != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: GestureDetector(
              onTap: onRemoveImage,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.white50, width: 1),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppStrings.closeIcon,
                    width: 24,
                    height: 24,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
