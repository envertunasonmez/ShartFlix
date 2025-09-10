import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';

class FavButton extends StatefulWidget {
  final bool isFav;
  final VoidCallback onTap;

  const FavButton({super.key, required this.isFav, required this.onTap});

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 72,
        width: 52,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: AppColors.white60, width: 1),
        ),
        child: Center(
          child: SvgPicture.asset(
            widget.isFav ? AppStrings.selectedFav : AppStrings.unselectedFav,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
