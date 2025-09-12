import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/widgets/cached_network_image/custom_cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String id;
  final String photoUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.id,
    required this.photoUrl,
  });

  static const Color primaryDark = Color(0xFF6F060B);
  static const double spacing = 12;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: primaryDark,
          child: photoUrl.isNotEmpty
              ? CustomCachedNetworkImage(
                  imageUrl: photoUrl,
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(44),
                )
              : const Icon(Icons.person, color: Colors.white, size: 30),
        ),
        const SizedBox(width: spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: AppTextStyles.heading20.copyWith(
                  color: AppColors.whiteColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'ID: $id',
                style: AppTextStyles.bodyNormal.copyWith(
                  color: AppColors.white60,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(minWidth: screenWidth * 0.2),
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.white5,
            borderRadius: BorderRadius.circular(spacing / 2),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(0, 50),
              alignment: Alignment.center,
            ),
            onPressed: () {
              context.go(AppRoutes.uploadPhoto);
            },
            child: Text(
              'Fotoğraf Ekle',
              style: AppTextStyles.heading18.copyWith(
                color: AppColors.whiteColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
