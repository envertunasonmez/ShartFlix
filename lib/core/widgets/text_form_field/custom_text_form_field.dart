import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? svgIconPath;
  final IconData? iconData;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.svgIconPath,
    this.iconData,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // Sabit renkler
    final labelColor = AppColors.white50; // %50 beyaz
    final iconColor = AppColors.whiteColor; // düz beyaz
    final borderColor = AppColors.white40;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: AppColors.white50, // input yazı rengi %50 beyaz
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.white70, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        prefixIcon: svgIconPath != null
            ? Padding(
                padding: const EdgeInsets.only(left: 4),
                child: SvgPicture.asset(
                  svgIconPath!,
                  width: 24,
                  height: 24,
                  color: iconColor, // icon rengi düz beyaz
                  fit: BoxFit.scaleDown,
                ),
              )
            : (iconData != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(iconData, color: iconColor),
                    )
                  : null),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
      ),
    );
  }
}
