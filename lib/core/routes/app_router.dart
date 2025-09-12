import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jr_case_boilerplate/features/auth/views/login/login_view.dart';
import 'package:jr_case_boilerplate/features/auth/views/register/register_view.dart';
import 'package:jr_case_boilerplate/features/home/view/home_view.dart';
import 'package:jr_case_boilerplate/features/profile/view/profile_view.dart';
import 'package:jr_case_boilerplate/features/splash/view/splash_view.dart';
import 'package:jr_case_boilerplate/features/upload_photo/view/upload_photo_view.dart';
import 'package:jr_case_boilerplate/main_wrapper.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    _fadeRoute(AppRoutes.splash, const SplashView()),
    _fadeRoute(AppRoutes.home, const HomeView()),
    _fadeRoute(AppRoutes.profile, const ProfileView()),
    _fadeRoute(AppRoutes.uploadPhoto, const UploadPhotoView()),
    _fadeRoute(AppRoutes.login, const LoginView()),
    _fadeRoute(AppRoutes.register, const RegisterView()),
    _fadeRoute(AppRoutes.mainWrapper, const MainWrapper()),
  ],
);

GoRoute _fadeRoute(String path, Widget page) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: page,
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          final fadeAnimation = Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
      );
    },
  );
}
