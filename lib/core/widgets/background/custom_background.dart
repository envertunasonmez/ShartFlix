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
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.mirror,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF3F0306),
                Color(0xFF090909),
                Color(0xFF090909),
                Color(0xFF090909),
              ],
              stops: [0.0, 0.45, 0.7, 1.0],
            ),
          ),
        ),

        Positioned(
          top: -height * 0.12,
          left: width * 0.25,
          right: width * 0.25,
          child: Container(
            height: height * 0.22,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(150, 75),
                bottomRight: Radius.elliptical(150, 75),
              ),
            ),
          ),
        ),

        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: Container(color: Colors.black.withOpacity(0.5)),
        ),

        SafeArea(child: child),
      ],
    );
  }
}
