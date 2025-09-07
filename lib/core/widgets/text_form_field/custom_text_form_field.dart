import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelColor = AppColors.white50; 
    final iconColor = AppColors.whiteColor; 
    final borderColor = AppColors.white20;

    return TextField(
      controller: widget.controller,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      style: AppTextStyles.bodyNormal.copyWith(color: AppColors.whiteColor),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: AppTextStyles.bodyNormal.copyWith(color: labelColor),
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
          vertical: 20,
        ),
        prefixIcon: widget.svgIconPath != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SvgPicture.asset(
                  widget.svgIconPath!,
                  width: 28,
                  height: 28,
                  color: iconColor,
                  fit: BoxFit.scaleDown,
                ),
              )
            : (widget.iconData != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(widget.iconData, color: iconColor, size: 28),
                    )
                  : null),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 52,
          minHeight: 52,
        ),
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: _toggleVisibility,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    _isObscured ? AppStrings.hideIconPath : AppStrings.icSee,
                    width: 28,
                    height: 28,
                    color: AppColors.white80,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 52,
          minHeight: 52,
        ),
      ),
    );
  }
}
