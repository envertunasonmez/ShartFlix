import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';
import 'package:jr_case_boilerplate/features/auth/views/login/login_view.dart';

class LoginRedirect extends StatelessWidget {
  final double width;

  const LoginRedirect({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Hesabın var mı? ",
            style: AppTextStyles.bodyNormal.copyWith(color: AppColors.white70),
          ),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: "Giriş Yap",
            style: AppTextStyles.bodyNormal.copyWith(
              color: AppColors.whiteColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                debugPrint("Giriş Yap tıklandı!");
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginView(),
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
