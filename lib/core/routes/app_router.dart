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
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: AppRoutes.uploadPhoto,
      builder: (context, state) => const UploadPhotoView(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: AppRoutes.mainWrapper,
      builder: (context, state) => const MainWrapper(),
    ),
  ],
);
