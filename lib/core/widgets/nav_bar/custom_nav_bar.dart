import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(child: _navItem(index: 0, label: 'Anasayfa')),
          const SizedBox(width: 16),
          Expanded(child: _navItem(index: 1, label: 'Profil')),
        ],
      ),
    );
  }

  Widget _navItem({required int index, required String label}) {
    final bool isSelected = currentIndex == index;

    String iconPath;
    if (index == 0) {
      iconPath = isSelected
          ? AppStrings.selectedHome
          : AppStrings.unselectedHome;
    } else {
      iconPath = isSelected
          ? AppStrings.selectedProfile
          : AppStrings.unselectedProfile;
    }

    if (currentIndex == 0 && index == 1) {
      iconPath = AppStrings.unselectedProfile;
    }
    if (currentIndex == 1 && index == 0) {
      iconPath = AppStrings.unselectedHome;
    }

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(42),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.whiteColor,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodyNormal.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
