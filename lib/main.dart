import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jr_case_boilerplate/bloc/login/login_bloc.dart';
import 'package:jr_case_boilerplate/bloc/movie_list/movie_list_bloc.dart';
import 'package:jr_case_boilerplate/bloc/movie_list/movie_list_event.dart';
import 'package:jr_case_boilerplate/bloc/profile/profile_bloc.dart';
import 'package:jr_case_boilerplate/bloc/register/register_bloc.dart';
import 'package:jr_case_boilerplate/bloc/upload_photo/upload_photo_bloc.dart';
import 'package:jr_case_boilerplate/core/constants/app_strings.dart';
import 'package:jr_case_boilerplate/core/data/repositories/auth_repository.dart';
import 'package:jr_case_boilerplate/core/data/repositories/movie_repository.dart';
import 'package:jr_case_boilerplate/core/data/repositories/profile_repository.dart';
import 'package:jr_case_boilerplate/core/data/repositories/upload_photo_repository.dart';
import 'package:jr_case_boilerplate/core/data/services/auth_service.dart';
import 'package:jr_case_boilerplate/core/data/services/movie_service.dart';
import 'package:jr_case_boilerplate/core/data/services/profile_service.dart';
import 'package:jr_case_boilerplate/core/data/services/upload_photo_service.dart';
import 'package:jr_case_boilerplate/core/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              RegisterBloc(authRepository: AuthRepository(AuthService())),
        ),
        BlocProvider(
          create: (_) => LoginBloc(repository: AuthRepository(AuthService())),
        ),
        BlocProvider(
          create: (_) =>
              ProfileBloc(repository: ProfileRepository(ProfileService())),
        ),
        BlocProvider(
          create: (_) => UploadPhotoBloc(
            repository: UploadPhotoRepository(UploadPhotoService()),
          ),
        ),
        BlocProvider(
          create: (_) =>
              MovieBloc(MovieRepository(MovieService()))
                ..add(FetchMovies(page: 1)),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        routerConfig: appRouter,
      ),
    );
  }
}
