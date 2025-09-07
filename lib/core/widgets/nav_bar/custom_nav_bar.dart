import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';

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

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(42),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.whiteColor,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.bodyNormal.copyWith(
            color: isSelected
                ? AppColors.whiteColor
                : AppColors.whiteColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
