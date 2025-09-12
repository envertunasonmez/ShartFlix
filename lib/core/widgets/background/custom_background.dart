import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final Color? gradientStart;
  final Color? gradientMiddle;

  const CustomBackground({
    super.key,
    required this.child,
    this.gradientStart,
    this.gradientMiddle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final startColor = gradientStart ?? AppColors.blackColor;
    final middleColor = gradientMiddle ?? const Color(0xFF1A0000);

    return Stack(
      children: [
        Container(color: AppColors.blackColor),

        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 0.8,
              colors: [
                startColor,
                startColor,
                middleColor,
                middleColor,
                const Color(0xFF1A0000),
                AppColors.blackColor,
              ],
              stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
            ),
          ),
        ),

        Positioned(
          top: -height * 0.16,
          left: width * 0.25,
          right: width * 0.25,
          child: Container(
            height: height * 0.22,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  (gradientStart ?? AppColors.blackColor).withOpacity(0.6),
                  (gradientMiddle ?? const Color(0xFF1A0000)).withOpacity(0.3),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(150, 75),
                bottomRight: Radius.elliptical(150, 75),
              ),
            ),
          ),
        ),

        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: Container(color: AppColors.blackColor.withOpacity(0.3)),
        ),

        SafeArea(child: child),
      ],
    );
  }
}
