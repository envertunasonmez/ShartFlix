import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/widgets/dash_border_painter.dart';

class PhotoUploadSection extends StatelessWidget {
  final ImageProvider? selectedImage;
  final VoidCallback onPickImage;

  const PhotoUploadSection({
    super.key,
    required this.selectedImage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                ? DecorationImage(
                    image: selectedImage!,
                    fit: BoxFit.cover,
                  )
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
    );
  }
}
