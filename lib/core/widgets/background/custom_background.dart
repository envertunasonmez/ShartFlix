import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Stack(
      children: [
        Container(color: AppColors.blackColor),

        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 0.8,
              colors: [
                AppColors.primary,
                AppColors.primary,
                AppColors.primaryDark,
                AppColors.primaryDark,
                Color(0xFF1A0000),
                Colors.black,
              ],
              stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
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
                  AppColors.primary.withOpacity(0.6),
                  AppColors.primaryDark.withOpacity(0.3),
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
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),

        SafeArea(child: child),
      ],
    );
  }
}
