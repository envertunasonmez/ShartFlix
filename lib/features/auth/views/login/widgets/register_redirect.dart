import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/register_view.dart';

class RegisterRedirect extends StatelessWidget {
  final double width;

  const RegisterRedirect({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Hesabın yok mu? ",
            style: AppTextStyles.bodyNormal.copyWith(color: AppColors.white70),
          ),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: "Kayıt ol",
            style: AppTextStyles.bodyNormal.copyWith(
              color: AppColors.whiteColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                debugPrint("Kayıt ol tıklandı!");
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const RegisterView(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          final offsetAnimation =
                              Tween<Offset>(
                                begin: const Offset(1.0, 0.0), 
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                              );
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}
