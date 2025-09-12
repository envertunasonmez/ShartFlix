import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? svgIconPath;
  final IconData? iconData;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool hasError;
  final String? errorText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.svgIconPath,
    this.iconData,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.hasError = false,
    this.errorText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
    final labelColor = widget.hasError ? AppColors.error : AppColors.white50;
    final iconColor = widget.hasError ? AppColors.error : AppColors.whiteColor;
    final borderColor = widget.hasError ? AppColors.error : AppColors.white20;
    final textColor = widget.hasError ? AppColors.error : AppColors.whiteColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          style: AppTextStyles.bodyNormal.copyWith(color: textColor),
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white5,
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
              borderSide: BorderSide(
                color: widget.hasError ? AppColors.error : AppColors.white70,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.error, width: 2),
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
                          child: Icon(
                            widget.iconData,
                            color: iconColor,
                            size: 28,
                          ),
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
                        _isObscured
                            ? AppStrings.hideIconPath
                            : AppStrings.icSee,
                        width: 28,
                        height: 28,
                        color: AppColors.white80,
                      ),
                    ),
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 52,
              minHeight: 52,
            ),
            errorStyle: const TextStyle(height: 0),
          ),
        ),
        if (widget.hasError && widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 8),
            child: Text(
              widget.errorText!,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
            ),
          ),
      ],
    );
  }
}
